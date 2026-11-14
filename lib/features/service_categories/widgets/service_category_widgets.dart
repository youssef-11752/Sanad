import 'package:flutter/material.dart';
import 'package:sanad/features/service_categories/models/service_category.dart';

const categoriesPageColor = Color(0xFFFBF3DF);
const categoriesCardColor = Color(0xFFE5E9D6);
const categoriesTealColor = Color(0xFF075B53);
const categoriesMutedColor = Color(0xFF888A7F);

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(
              Icons.arrow_forward_rounded,
              color: categoriesTealColor,
              size: 18,
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
        key: const Key('category-search'),
        controller: controller,
        onChanged: onChanged,
        textAlign: TextAlign.right,
        style: const TextStyle(color: Colors.white, fontSize: 11),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70, fontSize: 10),
          suffixIcon: const Icon(Icons.search, color: Colors.white70, size: 17),
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
            border: Border.all(color: const Color(0xFFE2DEC9)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F5E5948),
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 29,
                height: 29,
                decoration: BoxDecoration(
                  color: const Color(0xFF63796C),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(category.icon, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                color: Color(0xFF61938A),
                size: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
