import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/client/client_home/models/service_model.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

/// Grid of tappable service cards (icon + title) shown on the customer home screen.
class ServiceCards extends StatelessWidget {
  // list of services displayed in the gridview
  final List<ServiceModel> services;
  final ValueChanged<ServiceModel>? onServiceSelected;

  const ServiceCards({
    super.key,
    required this.services,
    this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, //take only the height it needs "not entire height of the screen"
      // number of service cards
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 cards in each row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.55,
      ),
      // build each card using its index
      // each card is a bordered, rounded tile that reports the tapped service to the parent
      itemBuilder: (context, index) {
        final service = services[index];
        final title = service.localizedTitle(AppLocalizations.of(context)!);
        return Material(
          color: AppThemes.whiteColor,
          borderRadius: BorderRadius.circular(13),
          child: InkWell(
            // no tap handler means the card is display-only
            onTap: onServiceSelected == null
                ? null
                : () => onServiceSelected!(service),
            borderRadius: BorderRadius.circular(13),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: AppThemes.darkCremey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    service.iconAsset,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      AppThemes.greenColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppThemes.darkGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
