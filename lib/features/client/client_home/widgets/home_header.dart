import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';

/// Top part of the client home screen: notification button, current service address and the search field.
/// All text and search callbacks come from the parent screen, which owns the state.
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.address,
    required this.addressTitle,
    required this.searchHint,
    required this.onSearchChanged,
    required this.onSearchSubmitted,
    super.key,
  });

  final String address;
  final String addressTitle;
  final String searchHint;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onSearchSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Notification button (UI only for now, no tap handler yet).
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppThemes.redColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),

            // Spacer pushes the address block to the opposite side of the row.
            Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addressTitle,
                  style: TextStyle(fontSize: 16, color: AppThemes.hiAccount),
                ),
                SizedBox(height: 3),
                // Single line with ellipsis so a long address can't break the layout.
                Text(
                  address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppThemes.greenColor,
                  ),
                ),
              ],
            ),

            SizedBox(width: 10),

            Icon(
              Icons.location_on_outlined,
              color: AppThemes.greenColor,
              size: 26,
            ),
          ],
        ),

        SizedBox(height: 16),

        // Search field: filters services live on change, and the parent navigates to the categories page on submit.
        TextField(
          key: const Key('home-search'),
          // Match the current locale direction so Arabic input and hint align properly.
          textDirection: Directionality.of(context),
          textInputAction: TextInputAction.search,
          onChanged: onSearchChanged,
          onSubmitted: onSearchSubmitted,
          decoration: InputDecoration(
            hintText: searchHint,
            hintTextDirection: Directionality.of(context),
            hintStyle: TextStyle(fontSize: 12, color: AppThemes.hiAccount),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppThemes.greenColor,
              size: 22,
            ),
            filled: true,
            fillColor: AppThemes.whiteColor,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 13,
              horizontal: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: AppThemes.darkCremey),
            ),
          ),
        ),
      ],
    );
  }
}
