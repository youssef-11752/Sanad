import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/core/constants/colors.dart' show Boxshadowcolor;
import 'package:sanad/features/client/client_services_categories/models/service_category.dart';

// Colors used across the categories screen.
const categoriesPageColor = AppThemes.cremeyColor;
const categoriesCardColor = AppThemes.privacyColor;
const categoriesTealColor = AppThemes.greenColor;
const categoriesMutedColor = AppThemes.hiAccount;

/// Header with back button, title and subtitle (text is aligned to the end for RTL).
class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({
    required this.title,
    required this.subtitle,
    required this.backLabel,
    required this.isArabic,
    required this.onBack,
    super.key,
  });

  final String title;
  final String subtitle;
  final String backLabel;
  final bool isArabic;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              tooltip: backLabel,
              onPressed: onBack,
              // Mirror the back arrow for Arabic.
              icon: Icon(
                isArabic
                    ? Icons.arrow_forward_rounded
                    : Icons.arrow_back_rounded,
                color: categoriesTealColor,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: categoriesTealColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          textAlign: TextAlign.end,
          style: const TextStyle(color: categoriesMutedColor, fontSize: 10),
        ),
      ],
    );
  }
}

/// Search box at the top of the categories list. Reports every change to the parent.
class CategorySearchField extends StatelessWidget {
  const CategorySearchField({
    required this.controller,
    required this.hint,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextField(
        // Key lets widget tests find the field.
        key: const Key('category-search'),
        controller: controller,
        onChanged: onChanged,
        textAlign: TextAlign.right,
        style: const TextStyle(color: AppThemes.whiteColor, fontSize: 11),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: AppThemes.privacyColor,
            fontSize: 10,
          ),
          suffixIcon: const Icon(
            Icons.search,
            color: AppThemes.privacyColor,
            size: 17,
          ),
          filled: true,
          fillColor: categoriesTealColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

/// Tappable card for one category: icon, title, short description and a chevron.
class ServiceCategoryCard extends StatelessWidget {
  const ServiceCategoryCard({
    required this.category,
    required this.onTap,
    super.key,
  });

  final ServiceCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Material + InkWell gives the ripple effect on the rounded card.
    return Material(
      color: categoriesCardColor,
      borderRadius: BorderRadius.circular(11),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11),
        child: Container(
          constraints: const BoxConstraints(minHeight: 52),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: AppThemes.darkCremey),
            boxShadow: const [
              BoxShadow(
                color: Boxshadowcolor,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon badge on the leading side.
              Container(
                width: 29,
                height: 29,
                decoration: BoxDecoration(
                  color: AppThemes.mediumGreen,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: SvgPicture.asset(
                  category.iconAsset,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AppThemes.whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title is one line, description up to two lines, to keep cards a uniform height.
                    Text(
                      category.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: categoriesTealColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: categoriesMutedColor,
                        fontSize: 8,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_left_rounded,
                color: AppThemes.greenColor,
                size: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
