import 'package:material_ui/material_ui.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:go_router/go_router.dart';
import 'package:sanad/features/main_navigation/widgets/main_bottom_navigation.dart';
import 'package:sanad/features/client/client_requests/models/request_item.dart';
import 'package:sanad/features/client/client_requests/widgets/current_request_card.dart';
import 'package:sanad/features/client/client_requests/widgets/past_request_card.dart';
import 'package:sanad/features/client/client_requests/widgets/request_section_title.dart';
import 'package:sanad/features/client/client_requests/widgets/request_status_colors.dart';
import 'package:sanad/features/client/client_requests/widgets/requests_header.dart';
import 'package:sanad/features/client/client_requests/widgets/requests_tabs.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum _RequestsTab { current, previous }

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({
    super.key,
    this.ordersFuture,
    this.ordersLoadError,
    this.onRetry,
    this.onDeleteIssue,
  });

  final Future<List<RequestItem>>? ordersFuture;
  final String? ordersLoadError;
  final VoidCallback? onRetry;
  final Future<void> Function(String issueId)? onDeleteIssue;

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  _RequestsTab _selectedTab = _RequestsTab.current;
  late Future<List<RequestItem>> _ordersFuture;
  final Set<String> _deletingIssueIds = {};

  @override
  void initState() {
    super.initState();
    _ordersFuture = widget.ordersFuture ?? _initialOrdersFuture();
  }

  @override
  void didUpdateWidget(covariant MyRequestsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.ordersFuture != oldWidget.ordersFuture ||
        widget.ordersLoadError != oldWidget.ordersLoadError) {
      _ordersFuture = widget.ordersFuture ?? _initialOrdersFuture();
    }
  }

  Future<List<RequestItem>> _initialOrdersFuture() {
    if (widget.ordersLoadError != null) {
      return Future.value(const <RequestItem>[]);
    }
    return _loadOrders();
  }

  String _statusLabel(RequestStatus status, AppLocalizations localizations) {
    return switch (status) {
      RequestStatus.pending => localizations.pendingStatus,
      RequestStatus.fulfilled => localizations.fulfilledStatus,
    };
  }

  Future<List<RequestItem>> _loadOrders() async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user == null) {
      throw StateError('No signed-in user is available.');
    }

    final orderRows = await client
        .from('orders')
        .select(
          'id, issue_id, provider_id, notes, status, scheduled_at, '
          'completed_at, created_at, issue:issues(title)',
        )
        .eq('user_id', user.id)
        .inFilter('status', ['pending', 'accepted', 'in_progress', 'completed'])
        .order('created_at', ascending: false);

    final orders = orderRows.map(RequestItem.fromOrder).toList();
    final orderedIssueIds = orderRows
        .map((order) => order['issue_id'])
        .whereType<String>()
        .toSet();
    final issueRows = await client
        .from('issues')
        .select('id, provider_id, title, status, created_at')
        .eq('user_id', user.id)
        .inFilter('status', ['pending', 'accepted', 'in_progress', 'completed'])
        .order('created_at', ascending: false);
    final unassignedIssues = issueRows
        .where((issue) => !orderedIssueIds.contains(issue['id']))
        .map(RequestItem.fromIssue);

    return [...orders, ...unassignedIssues];
  }

  void _retryLoadOrders() {
    setState(() {
      _ordersFuture = _loadOrders();
    });
  }

  Future<void> _deleteUnassignedIssue(String issueId) async {
    final deleteIssue = widget.onDeleteIssue;
    if (deleteIssue != null) {
      await deleteIssue(issueId);
      return;
    }

    final client = Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user == null) {
      throw StateError('No signed-in user is available.');
    }

    final deletedRows = await client
        .from('issues')
        .delete()
        .eq('id', issueId)
        .eq('user_id', user.id)
        .eq('status', 'pending')
        .isFilter('provider_id', null)
        .select('id');
    if (deletedRows.isEmpty) {
      throw StateError('The request is no longer available for deletion.');
    }
  }

  Future<void> _confirmDeleteRequest(
    RequestItem request,
    AppLocalizations localizations,
  ) async {
    if (!request.canDelete || _deletingIssueIds.contains(request.id)) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.deleteRequestTitle),
        content: Text(localizations.deleteRequestConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(localizations.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(localizations.deleteButton),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() {
      _deletingIssueIds.add(request.id);
    });

    try {
      await _deleteUnassignedIssue(request.id);
      if (!mounted) return;
      setState(() {
        _deletingIssueIds.remove(request.id);
        _ordersFuture = _ordersFuture.then(
          (requests) =>
              requests.where((item) => item.id != request.id).toList(),
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.requestDeletedMessage)),
      );
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _deletingIssueIds.remove(request.id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${localizations.requestDeleteError}\n$error')),
      );
    }
  }

  Widget _buildLoadError(AppLocalizations localizations, String error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${localizations.ordersLoadError}\n$error',
          textAlign: TextAlign.center,
          style: const TextStyle(color: requestMutedColor, fontSize: 13),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: widget.onRetry ?? _retryLoadOrders,
          child: Text(localizations.retryButton),
        ),
      ],
    );
  }

  Widget _buildOrdersContent(AppLocalizations localizations, bool isArabic) {
    return FutureBuilder<List<RequestItem>>(
      future: _ordersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        final loadError =
            widget.ordersLoadError ??
            (snapshot.hasError ? snapshot.error.toString() : null);
        final hasLoadError = loadError != null;
        final requests = hasLoadError
            ? const <RequestItem>[]
            : snapshot.requireData;

        final pendingRequests = requests
            .where((request) => request.status == RequestStatus.pending)
            .toList();

        final fulfilledRequests = requests
            .where((request) => request.status == RequestStatus.fulfilled)
            .toList();

        return SingleChildScrollView(
          padding: const widgets.EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RequestsHeader(
                    title: localizations.requestsTitle,
                    subtitle: localizations.requestsSubtitle,
                    isArabic: isArabic,
                    backLabel: localizations.backNavigation,
                    onBack: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/customer/management');
                      }
                    },
                  ),
                  const SizedBox(height: 18),
                  RequestsTabs(
                    currentLabel: localizations.currentRequestsTab(
                      pendingRequests.length,
                    ),
                    previousLabel: localizations.pastRequestsTab(
                      fulfilledRequests.length,
                    ),
                    currentSelected: _selectedTab == _RequestsTab.current,
                    onCurrentSelected: () {
                      setState(() {
                        _selectedTab = _RequestsTab.current;
                      });
                    },
                    onPreviousSelected: () {
                      setState(() {
                        _selectedTab = _RequestsTab.previous;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  if (_selectedTab == _RequestsTab.current)
                    RequestSectionTitle(localizations.currentOrdersSection)
                  else
                    RequestSectionTitle(localizations.pastVisitsSection),
                  const SizedBox(height: 10),
                  if (hasLoadError)
                    _buildLoadError(localizations, loadError)
                  else if (_selectedTab == _RequestsTab.current) ...[
                    if (pendingRequests.isEmpty)
                      Text(
                        localizations.noCurrentOrders,
                        style: const TextStyle(
                          color: requestMutedColor,
                          fontSize: 13,
                        ),
                      )
                    else
                      for (final request in pendingRequests) ...[
                        CurrentRequestCard(
                          request: request,
                          statusLabel: _statusLabel(
                            request.status,
                            localizations,
                          ),
                          onDelete: request.canDelete
                              ? () => _confirmDeleteRequest(
                                  request,
                                  localizations,
                                )
                              : null,
                          isDeleting: _deletingIssueIds.contains(request.id),
                        ),
                        const SizedBox(height: 10),
                      ],
                  ] else ...[
                    if (fulfilledRequests.isEmpty)
                      Text(
                        localizations.noPreviousOrders,
                        style: const TextStyle(
                          color: requestMutedColor,
                          fontSize: 13,
                        ),
                      )
                    else
                      for (final request in fulfilledRequests) ...[
                        PastRequestCard(
                          request: request,
                          statusLabel: _statusLabel(
                            request.status,
                            localizations,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                  ],
                  if (_selectedTab == _RequestsTab.current) ...[
                    const SizedBox(height: 4),
                    OutlinedButton(
                      onPressed: () => context.push('/customer/new-request'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: requestTealColor,
                        backgroundColor: requestCardColor,
                        side: const BorderSide(color: requestBorderColor),
                        minimumSize: const Size.fromHeight(40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Text(
                        localizations.newRequestButton,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: requestPageColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(child: _buildOrdersContent(localizations, isArabic)),
              MainBottomNavigation(
                selectedDestination: MainNavigationDestination.requests,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
