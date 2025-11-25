import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysandwich_counter/main.dart';

void main() {
  testWidgets("Increment and decrement buttons work", (tester) async {
    await tester.pumpWidget(const App());

    // Find buttons
    final addButton = find.text("Add");
    final removeButton = find.text("Remove");

    // Quantity starts at 0
    expect(find.text("Quantity: 0"), findsOneWidget);

    // Tap Add
    await tester.tap(addButton);
    await tester.pump();

    expect(find.text("Quantity: 1"), findsOneWidget);

    // Tap Remove
    await tester.tap(removeButton);
    await tester.pump();

    expect(find.text("Quantity: 0"), findsOneWidget);
  });

  testWidgets("Max quantity disables Add button", (tester) async {
    await tester.pumpWidget(const App());

    final addButton = find.text("Add");

    // Press until max (max = 5)
    for (int i = 0; i < 5; i++) {
      await tester.tap(addButton);
      await tester.pump();
    }

    expect(find.text("Quantity: 5"), findsOneWidget);
    expect(tester.widget<ElevatedButton>(addButton).onPressed, isNull);
  });
}
