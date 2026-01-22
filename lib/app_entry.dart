import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/repositories/order_repository.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() => runApp(const App());

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

enum BreadType { white, wholemeal, italianHerbs }

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late final OrderRepository _orderRepository;
  final TextEditingController _notesController = TextEditingController();
  bool _isFootlong = true;
  BreadType _selectedBreadType = BreadType.white;
  bool _isToasted = false;

  final PricingRepository _pricing = PricingRepository();

  @override
  void initState() {
    super.initState();
    _orderRepository = OrderRepository(maxQuantity: widget.maxQuantity);
    _notesController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  VoidCallback? _getIncreaseCallback() {
    if (_orderRepository.canIncrement) {
      return () => setState(() => _orderRepository.increment());
    }
    return null;
  }

  VoidCallback? _getDecreaseCallback() {
    if (_orderRepository.canDecrement) {
      return () => setState(() => _orderRepository.decrement());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final sandwichType = _isFootlong ? 'footlong' : 'six-inch';
    final noteForDisplay = _notesController.text.isEmpty ? 'No notes added.' : _notesController.text;
    final sizeEnum = _isFootlong ? SandwichSize.footlong : SandwichSize.sixInch;
    final total = _pricing.totalPrice(quantity: _orderRepository.quantity, size: sizeEnum);

    return Scaffold(
      appBar: AppBar(title: const Text('Sandwich Counter', style: heading1)),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${_orderRepository.quantity} x $sandwichType', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Total: £${total.toStringAsFixed(2)}'),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('six-inch', style: normalText),
                    Switch(
                      key: const Key('size_switch'),
                      value: _isFootlong,
                      onChanged: (v) => setState(() => _isFootlong = v),
                    ),
                    const Text('footlong', style: normalText),
                  ],
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    key: const Key('notes_textfield'),
                    controller: _notesController,
                    decoration: const InputDecoration(labelText: 'Add a note (e.g., no onions)'),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('untoasted', style: normalText),
                    Switch(
                      key: const Key('toast_switch'),
                      value: _isToasted,
                      onChanged: (v) => setState(() => _isToasted = v),
                    ),
                    const Text('toasted', style: normalText),
                  ],
                ),

                const SizedBox(height: 8),
                Text('Toasted: ${_isToasted ? 'Yes' : 'No'}'),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _getIncreaseCallback(),
                      child: const Text('Add'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _getDecreaseCallback(),
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
