import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad/features/main_navigation/widgets/main_bottom_navigation.dart';
import 'package:sanad/features/client/client_services_categories/models/service_category.dart';
import 'package:sanad/features/client/client_services_categories/widgets/service_category_widgets.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

/// Lists the home service categories with a search box. Can be opened with a
/// pre-filled search query (e.g. coming from the home search).
class ServiceCategoriesScreen extends StatefulWidget {
  const ServiceCategoriesScreen({super.key, this.initialSearchQuery = ''});

  final String initialSearchQuery;

  @override
  State<ServiceCategoriesScreen> createState() =>
      _ServiceCategoriesScreenState();
}

class _ServiceCategoriesScreenState extends State<ServiceCategoriesScreen> {
  final _searchController = TextEditingController();
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    // Seed the search field and filter from the query passed in by the caller.
    _searchQuery = widget.initialSearchQuery;
    _searchController.text = widget.initialSearchQuery;
  }

  @override
  void dispose() {
    // The controller must be disposed to avoid leaking it.
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    // Arabic switches the whole screen to right-to-left.
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    // Categories are built here so titles/descriptions follow the current locale.
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
    // Case-insensitive filter on title or description.
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    final visibleCategories = categories.where((category) {
      return category.title.toLowerCase().contains(normalizedQuery) ||
          category.description.toLowerCase().contains(normalizedQuery);
    }).toList();

    // Force text direction explicitly based on the app language.
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: categoriesPageColor,
        body: SafeArea(
          bottom: false,
          // Cap the width so the layout stays phone-like on wide screens.
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
                            backLabel: localizations.backNavigation,
                            isArabic: isArabic,
                            // Go back if there is history, otherwise fall back to the management page.
                            onBack: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go('/customer/management');
                              }
                            },
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
                            // Re-filter the list on every keystroke.
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                          ),
                          const SizedBox(height: 12),
                          // One card per visible category, with a gap between cards but not after the last.
                          for (
                            var index = 0;
                            index < visibleCategories.length;
                            index++
                          ) ...[
                            ServiceCategoryCard(
                              category: visibleCategories[index],
                              // Tapping a card starts a new request, passing the category title along.
                              onTap: () => context.push(
                                '/customer/new-request',
                                extra: visibleCategories[index].title,
                              ),
                            ),
                            if (index != visibleCategories.length - 1)
                              const SizedBox(height: 9),
                          ],
                          // Empty state when the search matches nothing.
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
        // Bottom nav is fixed outside the scrolling area.
        bottomNavigationBar: MainBottomNavigation(
          selectedDestination: MainNavigationDestination.categories,
        ),
      ),
    );
  }
}
