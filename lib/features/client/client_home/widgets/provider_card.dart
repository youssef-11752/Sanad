import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/features/client/client_home/models/provider_model.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

/// Renders the recommended providers as cards: name, specialty, rating, experience/availability, visit price and initials avatar.
class ProviderCards extends StatelessWidget {
  final List<ProviderModel> providers; // providers list from model file

  const ProviderCards({super.key, required this.providers});

  @override
  Widget build(BuildContext context) {
    // Localized strings (rating, experience, availability, price) come from the l10n files.
    final localizations = AppLocalizations.of(context)!;
    return Column(
      children: providers.map((provider) {
        // map loops on list and create new card for each item
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppThemes.whiteColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppThemes.darkCremey),
          ),
          child: Row(
            // i can't make the initials and text from right to left
            textDirection: TextDirection.rtl,
            children: [
              // First child sits on the left in the RTL row: typical response time.
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    localizations.homeResponseTime,
                    style: TextStyle(color: AppThemes.hiAccount, fontSize: 10),
                  ),
                ),
              ),
              // Middle column (3x wider): provider details.
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      provider.name,
                      style: TextStyle(
                        color: AppThemes.darkGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      localizations.homeProviderSpecialty,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppThemes.hiAccount,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 4),
                    // Rating line, formatted by the localization with the average and review count.
                    Text(
                      '★ ${localizations.providerRating(provider.rating, provider.reviewCount)}',
                      style: TextStyle(
                        color: AppThemes.greenColor,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 7),
                    // Two small chips: experience with availability (today or tomorrow), and the visit price.
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppThemes.privacyColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${localizations.providerExperience(provider.experienceYears)}, ${provider.availableToday ? localizations.providerAvailableToday : localizations.providerAvailableTomorrow}',
                                style: TextStyle(
                                  color: AppThemes.greenColor,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppThemes.privacyColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                localizations.providerVisitPrice(
                                  provider.price,
                                ),
                                style: TextStyle(
                                  color: AppThemes.greenColor,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              // Initials avatar at the end of the row.
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppThemes.privacyColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  provider.initial,
                  style: TextStyle(
                    color: AppThemes.greenColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(), // convert map to list
    );
  }
}
