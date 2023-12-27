import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_testing/homepage.dart';
import 'package:integration_testing/listview_screen.dart';
import 'package:integration_testing/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'end to end test',
    () {
      testWidgets(
        'verfiy login screen with correct username and passoword',
        (tester) async {
          await tester.pumpWidget(const app.MyApp());
          await tester
              .pumpAndSettle(); // wait until there are no more frames to execute
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(
              find.byKey(const Key('username_controller')), 'username');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), 'password');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byKey(const Key('login')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          expect(find.byType(HomePage), findsOneWidget);
          expect(
            find.descendant(
              of: find.byKey(const Key('loginKey')),
              matching: find.text('Login Successful'),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'verfiy login screen with incorrect username and passoword',
        (tester) async {
          app.main();
          await tester
              .pumpAndSettle(); // wait until there are no more frames to execute
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(
              find.byKey(const Key('username_controller')), 'tuhin');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '123456');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          expect(find.text('Invalid username or password'), findsOneWidget);
        },
      );

      testWidgets(
        'test litview builder by scroll until visible',
        (tester) async {
          await tester.pumpWidget(const MaterialApp(home: ListViewScreen()));
          await tester
              .pumpAndSettle(); // wait until there are no more frames to execute

          final listFinder = find.byType(Scrollable);
          // final itemFinder = find.byKey(const ValueKey('item_50_text'));
          final itemFinder = find.text('test_99_text');

          // Scroll until the item to be found appears.
          await tester.scrollUntilVisible(
            itemFinder,
            500.0,
            scrollable: listFinder,
          );

          // Verify that the item contains the correct text.
          expect(itemFinder, findsOneWidget);
        },
      );

      testWidgets(
        'test litview builder by drag',
        (tester) async {
          await tester.pumpWidget(const MaterialApp(home: ListViewScreen()));
          await tester
              .pumpAndSettle(); // wait until there are no more frames to execute

          await tester.drag(find.byType(ListView), const Offset(0.0, -10000.0));
          await tester.pumpAndSettle();

          // get the last item after scroll
          final item = find.byType(Text).last;

          // Verify that the item contains the correct text.
          expect(tester.widget<Text>(item).data, 'test_99_text');

          final expectAWidget = find.text('test_99_text');

          expect(expectAWidget, findsOneWidget);
        },
      );
    },
  );
}
