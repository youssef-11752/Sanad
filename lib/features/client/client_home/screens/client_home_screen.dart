import 'package:material_ui/material_ui.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/client/client_home/client_home_provider.dart';
import 'package:sanad/features/client/client_home/service_address.dart';
import 'package:sanad/features/client/client_requests/models/request_item.dart';
import 'package:sanad/features/client/client_requests/widgets/current_request_card.dart';
import 'package:sanad/features/client/client_requests/widgets/request_status_colors.dart';
import 'package:sanad/features/client/client_home/widgets/home_header.dart';
import 'package:sanad/features/client/client_home/widgets/provider_card.dart';
import 'package:sanad/features/client/client_home/widgets/service_card.dart';
import 'package:sanad/features/main_navigation/widgets/main_bottom_navigation.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Home page for customers: header with search, promo banner, service categories,
/// the latest active requests (loaded from Supabase) and recommended providers.
class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({
    super.key,
    this.serviceAddress,
    this.currentRequestsFuture,
  });

  // Both can be injected (e.g. in tests) to skip the Supabase calls.
  final String? serviceAddress;
  final Future<List<RequestItem>>? currentRequestsFuture;

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  // Text typed in the search field; filters the service list locally.
  String _searchQuery = '';
  // Kept in state so the request is not refetched on every rebuild.
  late Future<List<RequestItem>> _currentRequestsFuture;

  @override
  void initState() {
    super.initState();
    _currentRequestsFuture =
        widget.currentRequestsFuture ?? _loadCurrentRequests();
  }

  @override
  // Reload only if the injected future actually changed.
  void didUpdateWidget(covariant ClientHomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentRequestsFuture != oldWidget.currentRequestsFuture) {
      _currentRequestsFuture =
          widget.currentRequestsFuture ?? _loadCurrentRequests();
    }
  }

  // Fetches up to 3 of the current user's open requests (pending, accepted, in progress), newest first.
  Future<List<RequestItem>> _loadCurrentRequests() async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user == null) {
      throw StateError('No signed-in user is available.');
    }

    final rows = await client
        .from('issues')
        .select('id, provider_id, title, status, created_at')
        .eq('user_id', user.id)
        .inFilter('status', ['pending', 'accepted', 'in_progress'])
        .order('created_at', ascending: false)
        .limit(3);

    return rows.map(RequestItem.fromIssue).toList();
  }

  // Re-creates the future so the FutureBuilder runs again after an error.
  void _retryLoadingCurrentRequests() {
    setState(() {
      _currentRequestsFuture = _loadCurrentRequests();
    });
  }

  // Shows a spinner while loading, an error with retry, an empty message, or the request cards.
  Widget _buildCurrentRequests(AppLocalizations localizations) {
    return FutureBuilder<List<RequestItem>>(
      future: _currentRequestsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${localizations.ordersLoadError}\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: requestMutedColor, fontSize: 13),
              ),
              TextButton(
                onPressed: _retryLoadingCurrentRequests,
                child: Text(localizations.retryButton),
              ),
            ],
          );
        }

        final requests = snapshot.requireData;
        if (requests.isEmpty) {
          return Text(
            localizations.noCurrentOrders,
            style: const TextStyle(color: requestMutedColor, fontSize: 13),
          );
        }

        return Column(
          children: [
            for (final request in requests) ...[
              CurrentRequestCard(
                request: request,
                statusLabel: localizations.pendingStatus,
              ),
              const SizedBox(height: 10),
            ],
          ],
        );
      },
    );
  }

  // Prefer the address passed in; otherwise build it from the signed-in user's metadata.
  String _serviceAddress(AppLocalizations localizations) {
    final serviceAddress = widget.serviceAddress;
    if (serviceAddress != null) return serviceAddress;

    final metadata = Supabase.instance.client.auth.currentUser?.userMetadata;
    return serviceAddressFromMetadata(
      metadata,
      fallback: localizations.hintCity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final homeProvider = context.watch<ClientHomeProvider>();
    // Filter services by the localized title, case-insensitively.
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    final visibleServices = homeProvider.services.where((service) {
      return service
          .localizedTitle(localizations)
          .toLowerCase()
          .contains(normalizedQuery);
    }).toList();

    // Keep the ambient text direction so the layout flips correctly for Arabic.
    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        backgroundColor: AppThemes.cremeyColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const widgets.EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HomeHeader(
                  address: _serviceAddress(localizations),
                  addressTitle: localizations.homeAddressTitle,
                  searchHint: localizations.categoriesSearchHint,
                  // Typing filters the grid below; pressing search jumps to the categories page with the query.
                  onSearchChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  onSearchSubmitted: (value) {
                    final query = value.trim();
                    if (query.isNotEmpty) {
                      context.go(
                        '/customer/categories?q=${Uri.encodeQueryComponent(query)}',
                      );
                    }
                  },
                ),
                SizedBox(height: 17),
                // Green promo banner with a call to action that opens the categories page.
                Container(
                  // padding: const EdgeInsets.all(16),
                  padding: const widgets.EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: AppThemes.greenColor,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              localizations.homeBannerEyebrow,
                              style: TextStyle(
                                color: AppThemes.privacyColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Icon(
                              Icons.home_repair_service_outlined,
                              color: AppThemes.cremeyColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Column(
                          children: [
                            Text(
                              localizations.homeBannerTitle,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: AppThemes.whiteColor,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              localizations.homeBannerDescription,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: AppThemes.privacyColor,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 13),
                      SizedBox(
                        height: 43,
                        child: ElevatedButton(
                          onPressed: () => context.go('/customer/categories'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppThemes.redColor,
                            foregroundColor: AppThemes.whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: Text(
                            localizations.homeRequestServiceButton,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Services section header with a link to all requests.
                Row(
                  children: [
                    Text(
                      localizations.homeServicePrompt,
                      style: TextStyle(
                        color: AppThemes.darkGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => context.go('/customer/requests'),
                      child: Text(
                        localizations.allRequestsLink,
                        style: TextStyle(
                          color: AppThemes.redColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                // Show a message when the search matches nothing.
                if (visibleServices.isEmpty)
                  Text(
                    localizations.homeSearchNoResults,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppThemes.hiAccount,
                      fontSize: 12,
                    ),
                  )
                else
                  ServiceCards(
                    services: visibleServices,
                    // Tapping a service opens the new-request form with that service as the preselected title.
                    onServiceSelected: (service) {
                      context.push(
                        '/customer/new-request',
                        extra: service.title,
                      );
                    },
                  ),

                const SizedBox(height: 22),

                // Current orders section.
                Row(
                  children: [
                    Text(
                      localizations.currentOrdersSection,
                      style: TextStyle(
                        color: AppThemes.darkGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => context.go('/customer/requests'),
                      child: Text(
                        localizations.allRequestsLink,
                        style: TextStyle(
                          color: AppThemes.redColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildCurrentRequests(localizations),
                const SizedBox(height: 22),

                // Recommended providers section.
                Row(
                  children: [
                    Text(
                      localizations.homeRecommendedProviders,
                      style: TextStyle(
                        color: AppThemes.darkGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      localizations.viewAll,
                      style: TextStyle(color: AppThemes.redColor, fontSize: 10),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                ProviderCards(providers: homeProvider.providers),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        // Bottom tab bar with the home tab selected.
        bottomNavigationBar: MainBottomNavigation(
          selectedDestination: MainNavigationDestination.home,
        ),
      ),
    );
  }
}
