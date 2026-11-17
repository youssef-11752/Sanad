import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/models/profile_data.dart';
import 'package:sanad/features/profile/data/profile_repository.dart';
import 'package:sanad/features/profile/profile_settings_screen.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

// In-memory repository so tests can check saves without a database.
class _MemoryProfileRepository implements ProfileRepository {
  _MemoryProfileRepository(this.profile);

  ProfileData profile;
  int saveCount = 0;

  @override
  Future<ProfileData> loadCurrentProfile() async => profile;

  @override
  Future<void> saveCustomerProfile(ProfileData profile) async {
    this.profile = profile;
    saveCount++;
  }
}

// Helper that wraps a screen in an Arabic-localized MaterialApp.
Widget _localizedApp(Widget home) => MaterialApp(
  locale: const Locale('ar'),
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  home: home,
);

void main() {
  // Customers can edit their profile and the change goes through the repository.
  testWidgets('customer profile edits are saved through the repository', (
    tester,
  ) async {
    final repository = _MemoryProfileRepository(
      const ProfileData(
        fullName: 'سارة محمود',
        phoneNumber: '01012345678',
        city: 'القاهرة',
        district: 'المعادي',
      ),
    );
    await tester.pumpWidget(
      _localizedApp(
        ProfileSettingsScreen(
          accountType: ProfileAccountType.customer,
          repository: repository,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('الاسم ورقم الموبايل وبياناتك'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('تعديل الملف الشخصي').first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'مريم علي');
    await tester.tap(find.byTooltip('حفظ التعديلات'));
    await tester.pumpAndSettle();

    expect(repository.profile.fullName, 'مريم علي');
    expect(repository.saveCount, 1);
    expect(find.text('تم تحديث بيانات الملف الشخصي'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  // Providers only see their data; no edit button or form fields.
  testWidgets('provider profile stays read-only', (tester) async {
    final repository = _MemoryProfileRepository(
      const ProfileData(
        fullName: 'أحمد سمير',
        phoneNumber: '01012345678',
        city: 'القاهرة',
        district: 'مدينة نصر',
      ),
    );
    await tester.pumpWidget(
      _localizedApp(
        ProfileSettingsScreen(
          accountType: ProfileAccountType.provider,
          repository: repository,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('الاسم ورقم الموبايل وبياناتك'));
    await tester.pumpAndSettle();

    expect(find.text('الملف الشخصي'), findsOneWidget);
    expect(find.byTooltip('تعديل الملف الشخصي'), findsNothing);
    expect(find.byType(TextFormField), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
