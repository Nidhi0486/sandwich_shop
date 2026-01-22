// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sandwich_shop/main.dart';

void main() {
  testWidgets('OrderScreen add/remove buttons update quantity', (WidgetTester tester) async {
    // Build the OrderScreen directly inside a MaterialApp for test isolation.
    await tester.pumpWidget(const MaterialApp(home: OrderScreen(maxQuantity: 5)));
    await tester.pumpAndSettle();

    // Verify that the app bar is present (sanity check)
    expect(find.text('Sandwich Counter'), findsOneWidget);

    // Tap the 'Add' button and trigger a frame.
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Verify that our counter has incremented (quantity displayed somewhere)
    expect(find.textContaining('1 x'), findsOneWidget);

    // Tap the 'Remove' button and trigger a frame.
    await tester.tap(find.text('Remove'));
    await tester.pump();

    // Verify that our counter has decremented back to 0.
    expect(find.textContaining('0 x Six-inch'), findsOneWidget);
  });
}

// Minimal App implementation for the test so `App` is a defined class.
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _counter = 0;

  void _increment() => setState(() {
        _counter++;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Test App')),
        body: Center(child: Text('$_counter')),
        floatingActionButton: FloatingActionButton(
          onPressed: _increment,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}