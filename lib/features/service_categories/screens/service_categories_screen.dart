import 'package:flutter/material.dart';
import 'package:sanad/features/main_navigation/widgets/main_bottom_navigation.dart';
import 'package:sanad/features/request_status/screens/my_requests_screen.dart';
import 'package:sanad/features/service_categories/models/service_category.dart';
import 'package:sanad/features/service_categories/widgets/service_category_widgets.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

class ServiceCategoriesScreen extends StatefulWidget {
  const ServiceCategoriesScreen({super.key});

  @override
  State<ServiceCategoriesScreen> createState() =>
      _ServiceCategoriesScreenState();
}

class _ServiceCategoriesScreenState extends State<ServiceCategoriesScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleNavigation(
    BuildContext context,
    MainNavigationDestination destination,
    AppLocalizations localizations,
  ) {
    switch (destination) {
      case MainNavigationDestination.categories:
        return;
      case MainNavigationDestination.requests:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const MyRequestsScreen()),
        );
        return;
      case MainNavigationDestination.home:
      case MainNavigationDestination.account:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localizations.navigationComingSoon)),
        );
    }
  }

  void _showComingSoon(String categoryTitle, AppLocalizations localizations) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(localizations.categoryComingSoon(categoryTitle))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final categories = [
      ServiceCategory(
        title: localizations.applianceCategory,
        description: localizations.applianceCategoryDescription,
        icon: Icons.local_laundry_service_outlined,
      ),
      ServiceCategory(
        title: localizations.paintingCategory,
        description: localizations.paintingCategoryDescription,
        icon: Icons.format_paint_outlined,
      ),
      ServiceCategory(
        title: localizations.carpentryCategory,
        description: localizations.carpentryCategoryDescription,
        icon: Icons.handyman_outlined,
      ),
      ServiceCategory(
        title: localizations.electricalCategory,
        description: localizations.electricalCategoryDescription,
        icon: Icons.electrical_services_outlined,
      ),
      ServiceCategory(
        title: localizations.airConditioningCategory,
        description: localizations.airConditioningCategoryDescription,
        icon: Icons.ac_unit,
      ),
      ServiceCategory(
        title: localizations.plumbingCategory,
        description: localizations.plumbingCategoryDescription,
        icon: Icons.plumbing_outlined,
      ),
    ];
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    final visibleCategories = categories.where((category) {
      return category.title.toLowerCase().contains(normalizedQuery) ||
          category.description.toLowerCase().contains(normalizedQuery);
    }).toList();

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: categoriesPageColor,
        body: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CategoriesHeader(
                            title: localizations.categoriesTitle,
                            subtitle: localizations.categoriesSubtitle,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            localizations.homeServicesLabel,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              color: categoriesTealColor,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CategorySearchField(
                            controller: _searchController,
                            hint: localizations.categoriesSearchHint,
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                          ),
                          const SizedBox(height: 12),
                          for (
                            var index = 0;
                            index < visibleCategories.length;
                            index++
                          ) ...[
                            ServiceCategoryCard(
                              category: visibleCategories[index],
                              onTap: () => _showComingSoon(
                                visibleCategories[index].title,
                                localizations,
                              ),
                            ),
                            if (index != visibleCategories.length - 1)
                              const SizedBox(height: 9),
                          ],
                          if (visibleCategories.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Text(
                                localizations.categoriesNoResults,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: categoriesMutedColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: MainBottomNavigation(
          selectedDestination: MainNavigationDestination.categories,
          homeLabel: localizations.homeNavigation,
          categoriesLabel: localizations.categoriesNavigation,
          requestsLabel: localizations.myRequestsNavigation,
          accountLabel: localizations.accountNavigation,
          onDestinationSelected: (destination) =>
              _handleNavigation(context, destination, localizations),
        ),
      ),
    );
  }
}
