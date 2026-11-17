import 'package:sanad/core/theme/colors.dart';

/// Short semantic color names used by screens; they just alias the theme palette
/// so a palette change only needs to happen in one place.
abstract final class AppColors {
  static const teal = AppThemes.greenColor;
  static const lightTeal = AppThemes.privacyColor;
  static const coral = AppThemes.redColor;
  static const red = AppThemes.redColor;
  static const cream = AppThemes.cremeyColor;
  static const card = AppThemes.whiteColor;
  static const grey = AppThemes.hiAccount;
}
