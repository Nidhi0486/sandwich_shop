// Ensure this file is inside a Flutter project (created with `flutter create`) and
// that the Flutter SDK is installed. Then run `flutter pub get` in the project root.
// If you still see "Target of URI doesn't exist", open the project folder (not just the file)
// in a Flutter-enabled IDE (Android Studio, VS Code with Flutter plugin) so the analyzer
// can resolve `package:flutter/...`.
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

// ✅ Enums for sandwich size and bread type
enum SandwichSize { sixInch, footlong }

enum BreadType { white, wholemeal, italianHerbs }

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  SandwichSize _selectedSize = SandwichSize.sixInch;
  BreadType _selectedBread = BreadType.white;

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() => _quantity++);
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() => _quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Sandwich size selector
            SegmentedButton<SandwichSize>(
              segments: const [
                ButtonSegment(
                    value: SandwichSize.sixInch, label: Text('Six-inch')),
                ButtonSegment(
                    value: SandwichSize.footlong, label: Text('Footlong')),
              ],
              selected: <SandwichSize>{_selectedSize},
              onSelectionChanged: (Set<SandwichSize> newSelection) {
                setState(() {
                  _selectedSize = newSelection.first;
                });
              },
            ),

            const SizedBox(height: 20),

            // ✅ Bread type dropdown
            DropdownButton<BreadType>(
              value: _selectedBread,
              onChanged: (BreadType? newValue) {
                setState(() {
                  _selectedBread = newValue!;
                });
              },
              items: BreadType.values.map((BreadType type) {
                return DropdownMenuItem<BreadType>(
                  value: type,
                  child:
                      Text(type.name[0].toUpperCase() + type.name.substring(1)),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            // ✅ Display current quantity and type
            OrderItemDisplay(
              quantity: _quantity,
              sandwichType: _selectedSize == SandwichSize.footlong
                  ? 'Footlong'
                  : 'Six-inch',
              breadType: _selectedBread.name,
            ),

            const SizedBox(height: 30),

            // ✅ Buttons with spacing and alignment
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StyledButton(
                  text: 'Remove',
                  icon: Icons.remove,
                  onPressed: _quantity > 0 ? _decreaseQuantity : null,
                  color: Colors.red,
                ),
                StyledButton(
                  text: 'Add',
                  icon: Icons.add,
                  onPressed:
                      _quantity < widget.maxQuantity ? _increaseQuantity : null,
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Reusable styled button widget
class StyledButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color color;

  const StyledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon),
          if (icon != null) const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}

// ✅ Display widget for showing order info
class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String sandwichType;
  final String breadType;

  const OrderItemDisplay({
    super.key,
    required this.quantity,
    required this.sandwichType,
    required this.breadType,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$quantity $sandwichType sandwich(es) on $breadType bread',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    );
  }
}