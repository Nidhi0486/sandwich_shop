import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysandwich_counter/main.dart';

void main() {
  testWidgets('size switch toggles between six-inch and footlong',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    final sizeSwitch = find.byKey(const Key('sizeSwitch'));
    expect(sizeSwitch, findsOneWidget);

    await tester.tap(sizeSwitch);
    await tester.pump();

    expect(find.textContaining('footlong'), findsOneWidget);
  });

  testWidgets('toast switch toggles between untoasted and toasted',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    final toastSwitch = find.byKey(const Key('toastSwitch'));
    expect(toastSwitch, findsOneWidget);

    await tester.tap(toastSwitch);
    await tester.pump();

    expect(find.textContaining('Toasted: Yes'), findsOneWidget);
  });
}
