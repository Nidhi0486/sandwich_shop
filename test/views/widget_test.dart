import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/app_entry.dart';

void main() {
  testWidgets('Switch toggles sandwich size and toast state', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: OrderScreen(maxQuantity: 5)));
    await tester.pumpAndSettle();

    // Initially should show footlong (default _isFootlong true)
    expect(find.textContaining('0 x footlong'), findsOneWidget);

    // Toggle size switch
    final sizeSwitch = find.byKey(const Key('size_switch'));
    expect(sizeSwitch, findsOneWidget);
    await tester.tap(sizeSwitch);
    await tester.pumpAndSettle();

    // Now should show six-inch
    expect(find.textContaining('0 x six-inch'), findsOneWidget);

    // Toggle toast switch
    final toastSwitch = find.byKey(const Key('toast_switch'));
    expect(toastSwitch, findsOneWidget);
    // Initially unset: should show 'Toasted: No'
    expect(find.textContaining('Toasted: No'), findsOneWidget);
    await tester.tap(toastSwitch);
    await tester.pumpAndSettle();
    expect(find.textContaining('Toasted: Yes'), findsOneWidget);
  });
}
