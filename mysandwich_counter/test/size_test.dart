import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysandwich_counter/main.dart';

void main() {
  testWidgets('Switch test', (tester) async {
    await tester.pumpWidget(const App());

    // find the switch on the screen
    final switchFinder = find.byType(Switch);

    // tap the switch
    await tester.tap(switchFinder);
    await tester.pump();

    // check if "Footlong" text shows up
    expect(find.text('Footlong'), findsOneWidget);
  });
}