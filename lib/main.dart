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

// Simple local repository to keep track of quantity (ephemeral state)
class OrderRepository {
  int _quantity = 0;
  final int maxQuantity;

  OrderRepository({this.maxQuantity = 10});

  int get quantity => _quantity;

  bool get canIncrement => _quantity < maxQuantity;
  bool get canDecrement => _quantity > 0;

  void increment() {
    if (canIncrement) _quantity++;
  }

  void decrement() {
    if (canDecrement) _quantity--;
  }
}

// Enums for sandwich size and bread
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
  String _notes = '';

  @override
  void initState() {
    super.initState();
    _orderRepository = OrderRepository(maxQuantity: widget.maxQuantity);
  }

  void _increaseQuantity() {
    if (_orderRepository.canIncrement) {
      setState(() {
        _orderRepository.increment();
      });
    }
  }

  void _decreaseQuantity() {
    if (_orderRepository.canDecrement) {
      setState(() {
        _orderRepository.decrement();
      });
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
            // Size selector (simple buttons)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => setState(() => _selectedSize = SandwichSize.sixInch),
                  child: Text(
                    'Six-inch',
                    style: TextStyle(
                      fontWeight: _selectedSize == SandwichSize.sixInch ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => setState(() => _selectedSize = SandwichSize.footlong),
                  child: Text(
                    'Footlong',
                    style: TextStyle(
                      fontWeight: _selectedSize == SandwichSize.footlong ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Bread selector
            DropdownButton<BreadType>(
              value: _selectedBread,
              onChanged: (newValue) {
                setState(() {
                  _selectedBread = newValue!;
                });
              },
              items: BreadType.values.map((type) {
                return DropdownMenuItem<BreadType>(
                  value: type,
                  child: Text(type.name[0].toUpperCase() + type.name.substring(1)),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Order display
            OrderItemDisplay(
              quantity: _orderRepository.quantity,
              sandwichType: _selectedSize == SandwichSize.footlong ? 'Footlong' : 'Six-inch',
              breadType: _selectedBread.name,
            ),

            const SizedBox(height: 16),

            // Notes input
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Notes (e.g. no onions)',
              ),
              onChanged: (v) => setState(() => _notes = v),
            ),

            const SizedBox(height: 8),

            // Echo notes so the field is used
            Text('Notes: ${_notes.isEmpty ? '<none>' : _notes}'),

            const SizedBox(height: 12),

            // Buttons aligned at opposite sides
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: StyledButton(
                    text: 'Remove',
                    icon: Icons.remove,
                    onPressed: _orderRepository.canDecrement ? _decreaseQuantity : null,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StyledButton(
                    text: 'Add',
                    icon: Icons.add,
                    onPressed: _orderRepository.canIncrement ? _increaseQuantity : null,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable StyledButton
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
        backgroundColor: onPressed == null ? Colors.grey : color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String sandwichType;
  final String breadType;

  const OrderItemDisplay({super.key, required this.quantity, required this.sandwichType, required this.breadType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$quantity x $sandwichType',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Bread: $breadType'),
        const SizedBox(height: 8),
        Text('Total: £${(quantity * 11).toStringAsFixed(2)}'),
      ],
    );
  }
}