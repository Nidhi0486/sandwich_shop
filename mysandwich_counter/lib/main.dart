import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/repositories/order_repository.dart';

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

// Enums
enum SandwichSize { sixInch, footlong }
enum BreadType { white, wholemeal, italianHerbs }

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late final OrderRepository _orderRepository;

  SandwichSize _selectedSize = SandwichSize.sixInch;
  BreadType _selectedBread = BreadType.white;

  @override
  void initState() {
    super.initState();
    _orderRepository = OrderRepository(maxQuantity: widget.maxQuantity);
  }

  // Worksheet 4 callback helpers
  VoidCallback? _getIncreaseCallback() {
    if (_orderRepository.canIncrement) {
      return () => setState(() {
            _orderRepository.increment();
          });
    }
    return null;
  }

  VoidCallback? _getDecreaseCallback() {
    if (_orderRepository.canDecrement) {
      return () => setState(() {
            _orderRepository.decrement();
          });
    }
    return null;
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
            // Size selector
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

            // Bread dropdown
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

            // Display widget
            OrderItemDisplay(
              quantity: _orderRepository.quantity,
              sandwichType: _selectedSize == SandwichSize.footlong
                  ? 'Footlong'
                  : 'Six-inch',
              breadType: _selectedBread.name,
            ),

            const SizedBox(height: 30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StyledButton(
                  text: 'Remove',
                  icon: Icons.remove,
                  onPressed: _getDecreaseCallback(),
                  color: Colors.red,
                ),
                StyledButton(
                  text: 'Add',
                  icon: Icons.add,
                  onPressed: _getIncreaseCallback(),
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

// Styled button widget
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
          if (icon != null) Icon(i
