import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

// Main App Widget
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // A list of sample sandwich types to make the display varied
    final sandwichTypes = [
      'Footlong',
      'Mini',
      'Club',
      'Veggie',
      'BLT',
      'Turkey',
      'Chicken',
      'Italian',
      'Tuna',
      'Meatball',
    ];

    return MaterialApp(
      title: 'Sandwich Shop App', // ✅ Browser tab title
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sandwich Counter'),
        ),
        body: Center(
          // ✅ Makes the whole list scrollable
          child: Container(
            width: 350,
            height: 500,
            color: Colors.orange[50],
            padding: const EdgeInsets.all(12),
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                final type = sandwichTypes[index % sandwichTypes.length];
                final quantity = (index % 6) + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: OrderItemDisplay(quantity, type),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Custom StatelessWidget to display a sandwich order
class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$quantity $itemType sandwich(es): ${'🥪' * quantity}',
      style: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        ),
        );
        }
}