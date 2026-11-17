import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:sanad/features/customer_management/client_home_provider.dart';
import 'package:sanad/features/customer_management/screens/client_home_screen.dart';
import 'package:sanad/features/customer_management/service_address.dart';
import 'package:sanad/features/request_status/models/request_item.dart';
import 'package:sanad/features/request_status/screens/my_requests_screen.dart';
import 'package:sanad/features/service_categories/screens/service_categories_screen.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

// Placeholder page used as a stand-in for routes we only need to land on.
Widget _destination(String title) => Scaffold(
  body: Center(child: Text(title, key: const Key('destination-title'))),
);

// Builds a small router with just the customer routes, with injectable data
// so tests never touch the real backend.
GoRouter _router({
  Future<List<RequestItem>>? currentRequestsFuture,
  Future<List<RequestItem>>? requestsFuture,
  Future<void> Function(String issueId)? onDeleteIssue,
}) => GoRouter(
  initialLocation: '/customer/management',
  routes: [
    GoRoute(
      path: '/customer/management',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => ClientHomeProvider(),
        child: ClientHomeScreen(
          serviceAddress: 'المعادي، القاهرة',
          currentRequestsFuture:
              currentRequestsFuture ?? Future.value(const <RequestItem>[]),
        ),
      ),
    ),
    // Same query parameter the home search uses to pre-filter categories.
    GoRoute(
      path: '/customer/categories',
      builder: (context, state) => ServiceCategoriesScreen(
        initialSearchQuery: state.uri.queryParameters['q'] ?? '',
      ),
    ),
    GoRoute(
      path: '/customer/requests',
      builder: (context, state) => MyRequestsScreen(
        ordersFuture: requestsFuture ?? Future.value(const []),
        onDeleteIssue: onDeleteIssue,
      ),
    ),
    GoRoute(
      path: '/customer/new-request',
      // The extra value shows which category was passed to the new request page.
      builder: (context, state) =>
          _destination('new request: ${state.extra ?? 'none'}'),
    ),
  ],
);

// Wraps the router in a localized app; Arabic by default like the real app.
Widget _testApp(GoRouter router, {Locale locale = const Locale('ar')}) =>
    MaterialApp.router(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: router,
    );

void main() {
  // Only unassigned issues (no provider_id) can be deleted by the customer.
  test('an unassigned issue becomes a pending customer request', () {
    final request = RequestItem.fromIssue({
      'id': 'issue-1',
      'title': 'Fix a leaking pipe',
      'status': 'pending',
      'created_at': '2026-11-15T07:00:00Z',
    });

    expect(request.id, 'issue-1');
    expect(request.status, RequestStatus.pending);
    expect(request.title, 'Fix a leaking pipe');
    expect(request.canDelete, isTrue);
    expect(
      RequestItem.fromIssue({
        'id': 'assigned-issue',
        'title': 'Assigned issue',
        'status': 'pending',
        'provider_id': 'provider-1',
      }).canDelete,
      isFalse,
    );
  });

  // The address is built from the region and city saved at signup, with a fallback.
  test('service address uses the signed-up area and city', () {
    expect(
      serviceAddressFromMetadata(const {
        'region': 'المعادي',
        'city': 'القاهرة',
      }, fallback: 'اختار المدينة'),
      'المعادي، القاهرة',
    );
    expect(
      serviceAddressFromMetadata(const {}, fallback: 'اختار المدينة'),
      'اختار المدينة',
    );
  });

  // Requests supplied through currentRequestsFuture should show up on the home screen.
  testWidgets('home displays the signed-in customer current requests', (
    tester,
  ) async {
    final router = _router(
      currentRequestsFuture: Future.value([
        const RequestItem(
          id: 'issue-123',
          status: RequestStatus.pending,
          title: 'إصلاح تسريب المياه',
          provider: '',
          date: '2026-11-15T07:00:00Z',
        ),
      ]),
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(_testApp(router));
    await tester.pumpAndSettle();

    expect(find.text('إصلاح تسريب المياه'), findsOneWidget);
    expect(find.text('issue-123'), findsOneWidget);
    expect(find.text('SN-2048'), findsNothing);
  });

  // Walk through the bottom navigation: categories, my requests, then back home.
  testWidgets('home navigation opens categories and my requests', (
    tester,
  ) async {
    final router = _router();
    addTearDown(router.dispose);
    await tester.pumpWidget(_testApp(router));
    await tester.pumpAndSettle();

    expect(find.text('المعادي، القاهرة'), findsOneWidget);
    await tester.tap(find.text('الأقسام'));
    await tester.pumpAndSettle();
    expect(find.text('كل الأقسام'), findsOneWidget);

    await tester.tap(find.text('طلباتي').last);
    await tester.pumpAndSettle();
    expect(find.text('الطلبات الجارية'), findsOneWidget);

    await tester.tap(find.text('الرئيسية'));
    await tester.pumpAndSettle();
    expect(find.text('المعادي، القاهرة'), findsOneWidget);
  });

  // Switch to English and check texts, home search, and the path to a category card.
  testWidgets('customer home content follows the selected locale', (
    tester,
  ) async {
    final router = _router();
    addTearDown(router.dispose);
    await tester.pumpWidget(_testApp(router, locale: const Locale('en')));
    await tester.pumpAndSettle();

    expect(find.text('Service address'), findsOneWidget);
    expect(find.text('Skilled help, closer with Sanad'), findsOneWidget);
    expect(
      find.text('A skilled professional for every repair'),
      findsOneWidget,
    );
    expect(find.text('Request a service'), findsOneWidget);
    expect(find.text('What service do you need today?'), findsOneWidget);
    expect(find.text('Painting'), findsOneWidget);
    expect(find.text('النقاشة'), findsNothing);

    final search = find.byKey(const Key('home-search'));
    await tester.enterText(search, 'plumbing');
    await tester.pumpAndSettle();
    expect(find.text('Plumbing'), findsOneWidget);
    expect(find.text('Painting'), findsNothing);

    final requestButton = find.text('Request a service');
    await tester.ensureVisible(requestButton);
    await tester.pumpAndSettle();
    await tester.tap(requestButton);
    await tester.pumpAndSettle();

    final categorySearch = find.byKey(const Key('category-search'));
    await tester.enterText(categorySearch, 'plumbing');
    await tester.pumpAndSettle();
    final plumbingCard = find.ancestor(
      of: find.text('Plumbing'),
      matching: find.byType(InkWell),
    );
    await tester.ensureVisible(plumbingCard);
    await tester.pumpAndSettle();
    await tester.tap(plumbingCard);
    await tester.pumpAndSettle();
    expect(find.text('new request: Plumbing'), findsOneWidget);
  });

  // Back arrows should return to home from both secondary screens.
  testWidgets('category and request back arrows navigate to home', (
    tester,
  ) async {
    final router = _router();
    addTearDown(router.dispose);
    await tester.pumpWidget(_testApp(router));
    await tester.pumpAndSettle();

    await tester.tap(find.text('الأقسام'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('رجوع'));
    await tester.pumpAndSettle();
    expect(find.text('المعادي، القاهرة'), findsOneWidget);

    await tester.tap(find.text('طلباتي').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('رجوع'));
    await tester.pumpAndSettle();
    expect(find.text('المعادي، القاهرة'), findsOneWidget);
  });

  // Confirm dialog first, then the delete callback must receive the issue id.
  testWidgets('customer can delete an unassigned request', (tester) async {
    final deletedIssueIds = <String>[];
    final router = _router(
      requestsFuture: Future.value([
        const RequestItem(
          id: 'issue-delete-me',
          status: RequestStatus.pending,
          title: 'طلب غير مسند',
          provider: '',
          date: '2026-11-15T07:00:00Z',
          canDelete: true,
        ),
      ]),
      onDeleteIssue: (issueId) async {
        deletedIssueIds.add(issueId);
      },
    );
    addTearDown(router.dispose);
    router.go('/customer/requests');
    await tester.pumpWidget(_testApp(router));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('حذف الطلب'));
    await tester.pumpAndSettle();
    expect(
      find.text('متأكد إنك عايز تحذف الطلب؟ لا يمكن التراجع عن الحذف.'),
      findsOneWidget,
    );

    await tester.tap(find.text('حذف').last);
    await tester.pumpAndSettle();

    expect(deletedIssueIds, ['issue-delete-me']);
    expect(find.text('طلب غير مسند'), findsNothing);
    expect(find.text('لا توجد طلبات حالية.'), findsOneWidget);
  });

  // The "all requests" link on home goes to the requests screen.
  testWidgets('home all-requests link opens my requests', (tester) async {
    final router = _router();
    addTearDown(router.dispose);
    await tester.pumpWidget(_testApp(router));
    await tester.pumpAndSettle();

    await tester.tap(find.text('كل الطلبات').first);
    await tester.pumpAndSettle();

    expect(find.text('الطلبات الجارية'), findsOneWidget);
  });

  testWidgets('category selection opens a preselected new request', (
    tester,
  ) async {
    final router = _router();
    addTearDown(router.dispose);
    router.go('/customer/categories');
    await tester.pumpWidget(_testApp(router));
    await tester.pumpAndSettle();

    await tester.tap(find.text('السباكة'));
    await tester.pumpAndSettle();

    expect(find.text('new request: السباكة'), findsOneWidget);
  });

  // Tapping a filtered result on home goes straight to a new request.
  testWidgets('home search filters services and opens a new request', (
    tester,
  ) async {
    final router = _router();
    addTearDown(router.dispose);
    await tester.pumpWidget(_testApp(router));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('home-search')), 'السباكة');
    await tester.pumpAndSettle();
    expect(find.text('السباكة'), findsNWidgets(2));
    expect(find.text('النقاشة'), findsNothing);

    await tester.tap(find.text('السباكة').last);
    await tester.pumpAndSettle();
    expect(find.text('new request: السباكة'), findsOneWidget);
  });

  // Submitting the search from the keyboard opens the categories screen with the filter applied.
  testWidgets('home search submits to filtered categories', (tester) async {
    final router = _router();
    addTearDown(router.dispose);
    await tester.pumpWidget(_testApp(router));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('home-search')), 'السباكة');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(find.text('السباكة'), findsNWidgets(2));
    expect(find.text('النقاشة'), findsNothing);
  });

  // No category was chosen here, so the extra is null.
  testWidgets('my requests opens the new request flow', (tester) async {
    final router = _router();
    addTearDown(router.dispose);
    router.go('/customer/requests');
    await tester.pumpWidget(_testApp(router));
    await tester.pumpAndSettle();

    final createButton = find.text('اطلب خدمة جديدة');
    await tester.ensureVisible(createButton);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    expect(find.text('new request: none'), findsOneWidget);
  });
}
