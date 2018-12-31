// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

import 'package:relieve_app/main.dart';
import 'package:relieve_app/widget/item/title.dart';

void main() {
  testWidgets('boarding home test', (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      await tester.pumpWidget(MyApp());
      expect(find.text('Login Now'), findsOneWidget);
      expect(find.text('Sign In With Google'), findsOneWidget);
      expect(find.text('Don’t have an account ?'), findsOneWidget);
      expect(find.text('Register Here'), findsOneWidget);

      expect(find.byType(RaisedButton), findsNWidgets(2));
      expect(find.byType(FlatButton), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });

  testWidgets('boarding login test', (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      await tester.pumpWidget(MyApp());
      await tester
          .tap(find.byKey(Key('home-login'))); // navigate to boarding login
      await tester.pumpAndSettle();

      expect(find.text('Login Now'), findsOneWidget);
      expect(find.text('Don’t have an account ?'), findsOneWidget);
      expect(find.text('Register Here'), findsOneWidget);

      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(ThemedTitle), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(RaisedButton), findsOneWidget);
      expect(find.byType(FlatButton), findsNWidgets(2));
    });
  });
}
