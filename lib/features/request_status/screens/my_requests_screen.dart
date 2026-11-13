import 'package:flutter/material.dart';
import 'package:sanad/features/request_status/models/request_item.dart';
import 'package:sanad/features/request_status/widgets/request_status_widgets.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

enum _RequestsTab { current, previous }

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  _RequestsTab _selectedTab = _RequestsTab.current;

  void _showComingSoon(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  String _statusLabel(RequestStatus status, AppLocalizations localizations) {
    return switch (status) {
      RequestStatus.scheduled => localizations.scheduledVisitStatus,
      RequestStatus.completed => localizations.completedStatus,
      RequestStatus.completedRated => localizations.completedRatedStatus,
      RequestStatus.cancelled => localizations.cancelledStatus,
    };
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final currentRequest = RequestItem(
      id: 'SN-2048',
      status: RequestStatus.scheduled,
      title: localizations.currentServiceTitle,
      provider: localizations.currentProviderInfo,
      date: localizations.currentVisitDate,
    );
    final pastRequests = [
      RequestItem(
        id: 'SN-1982',
        status: RequestStatus.completed,
        title: localizations.pastRepairTitle,
        provider: localizations.pastRepairProvider,
        date: localizations.pastRepairDate,
      ),
      RequestItem(
        id: 'SN-1843',
        status: RequestStatus.completedRated,
        title: localizations.pastFridgeTitle,
        provider: localizations.pastFridgeProvider,
        date: localizations.pastFridgeDate,
      ),
      RequestItem(
        id: 'SN-1760',
        status: RequestStatus.cancelled,
        title: localizations.pastLightTitle,
        provider: localizations.pastLightProvider,
        date: localizations.pastLightDate,
      ),
    ];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: requestPageColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
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
                          ),
                          const SizedBox(height: 18),
                          RequestsTabs(
                            currentLabel: localizations.currentRequestsTab,
                            previousLabel: localizations.pastRequestsTab,
                            currentSelected:
                                _selectedTab == _RequestsTab.current,
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
                          if (_selectedTab == _RequestsTab.current) ...[
                            RequestSectionTitle(
                              localizations.currentOrdersSection,
                            ),
                            const SizedBox(height: 10),
                            CurrentRequestCard(
                              request: currentRequest,
                              statusLabel: _statusLabel(
                                currentRequest.status,
                                localizations,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 42,
                              child: FilledButton(
                                onPressed: () => _showComingSoon(
                                  localizations.trackRequestComingSoon(
                                    currentRequest.id,
                                  ),
                                ),
                                style: FilledButton.styleFrom(
                                  backgroundColor: requestRedColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                ),
                                child: Text(
                                  localizations.trackRequestButton(
                                    currentRequest.id,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            RequestSectionTitle(
                              localizations.pastVisitsSection,
                            ),
                          ] else ...[
                            RequestSectionTitle(
                              localizations.pastVisitsSection,
                            ),
                          ],
                          const SizedBox(height: 10),
                          for (final request in pastRequests) ...[
                            PastRequestCard(
                              request: request,
                              statusLabel: _statusLabel(
                                request.status,
                                localizations,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                          const SizedBox(height: 4),
                          OutlinedButton(
                            onPressed: () => _showComingSoon(
                              localizations.newRequestComingSoon,
                            ),
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
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              RequestsBottomNavigation(
                homeLabel: localizations.homeNavigation,
                categoriesLabel: localizations.categoriesNavigation,
                requestsLabel: localizations.myRequestsNavigation,
                accountLabel: localizations.accountNavigation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
