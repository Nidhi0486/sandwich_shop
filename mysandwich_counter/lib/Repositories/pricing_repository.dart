import 'package:flutter/material.dart';

// Minimal styles (you can move this to views/app_styles.dart later)
class AppStyles {
  static final ThemeData theme = ThemeData(
    primarySwatch: Colors.green,
    appBarTheme: const AppBarTheme(centerTitle: true),
    scaffoldBackgroundColor: Colors.white,
  );
}

const TextStyle normalText = TextStyle(fontSize: 16);
const TextStyle heading1 = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

// Simple repository implementations (you can move these to lib/repositories/)
class OrderRepository {
  int _quantity = 0;
  final int maxQuantity;
  OrderRepository({required this.maxQuantity});
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

class PricingRepository {
  static const double _priceSixInch = 7.0;
  static const double _priceFootlong = 11.0;

  double calculateTotal({
    required int quantity,
    required bool isFootlong,
  }) {
    if (quantity <= 0) return 0.0;
    final unit = isFootlong ? _priceFootlong : _priceSixInch;
    return unit * quantity;
  }

  // alias used by some tests/code
  double calculateTotalPrice({
    required int quantity,
    required bool isFootlong,
  }) =>
      calculateTotal(quantity: quantity, isFootlong: isFootlong);
}

enum BreadType { white, wheat, multigrain }

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop App',
      theme: AppStyles.theme,
      debugShowCheckedModeBanner: false,
      home: const OrderScreen(maxQuantity: 5),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;
  const OrderScreen({Key? key, this.maxQuantity = 10}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late final OrderRepository _orderRepository;
  final TextEditingController _notesController = TextEditingController();
  bool _isFootlong = true;
  bool _isToasted = false;
  BreadType _selectedBread = BreadType.white;
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

  void _onSandwichTypeChanged(bool value) {
    setState(() => _isFootlong = value);
  }

  @override
  Widget build(BuildContext context) {
    final sandwichType = _isFootlong ? 'Footlong' : 'Six-inch';
    final noteForDisplay =
        _notesController.text.isEmpty ? 'No notes added.' : _notesController.text;
    final total = _pricing.calculateTotal(
      quantity: _orderRepository.quantity,
      isFootlong: _isFootlong,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mr Tree Sandwiches', style: heading1),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OrderItemDisplay(
                quantity: _orderRepository.quantity,
                itemType: sandwichType,
                breadType: _selectedBread,
                orderNote: noteForDisplay,
                isToasted: _isToasted,
              ),
              const SizedBox(height: 20),

              // Size switch (keyed for tests)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('six-inch', style: normalText),
                  Switch(
                    key: const Key('sizeSwitch'),
                    value: _isFootlong,
                    onChanged: _onSandwichTypeChanged,
                  ),
                  const Text('footlong', style: normalText),
                ],
              ),

              const SizedBox(height: 8),

              // Toasted switch (keyed for tests)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('untoasted', style: normalText),
                  Switch(
                    key: const Key('toastSwitch'),
                    value: _isToasted,
                    onChanged: (v) => setState(() => _isToasted = v),
                  ),
                  const Text('toasted', style: normalText),
                ],
              ),

              const SizedBox(height: 12),

              // Bread selector using DropdownButton for compatibility
              DropdownButton<BreadType>(
                value: _selectedBread,
                onChanged: (BreadType? newValue) {
                  if (newValue == null) return;
                  setState(() => _selectedBread = newValue);
                },
                items: BreadType.values.map((b) {
                  return DropdownMenuItem<BreadType>(
                    value: b,
                    child: Text(
                      b.name[0].toUpperCase() + b.name.substring(1),
                      style: normalText,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextField(
                  key: const Key('notes_textfield'),
                  controller: _notesController,
                  decoration:
                      const InputDecoration(labelText: 'Add a note (e.g., no onions)'),
                ),
              ),

              const SizedBox(height: 16),

              Text('Total: £${total.toStringAsFixed(2)}', style: normalText),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyledButton(
                    onPressed: _getDecreaseCallback(),
                    icon: Icons.remove,
                    label: 'Remove',
                    backgroundColor: Colors.red,
                  ),
                  const SizedBox(width: 12),
                  StyledButton(
                    onPressed: _getIncreaseCallback(),
                    icon: Icons.add,
                    label: 'Add',
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StyledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final String label;
  final Color backgroundColor;

  const StyledButton({
    Key? key,
    required this.onPressed,
    this.icon,
    required this.label,
    this.backgroundColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 18),
          if (icon != null) const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String itemType;
  final BreadType breadType;
  final String orderNote;
  final bool isToasted;

  const OrderItemDisplay({
    Key? key,
    required this.quantity,
    required this.itemType,
    required this.breadType,
    required this.orderNote,
    required this.isToasted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text('Order Summary', style: heading1),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Quantity:', style: normalText), Text('$quantity', style: normalText)],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Type:', style: normalText), Text(itemType, style: normalText)],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Bread:', style: normalText), Text(breadType.name, style: normalText)],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Toasted:', style: normalText), Text(isToasted ? 'Yes' : 'No', style: normalText)],
            ),
            const SizedBox(height: 8),
            Align(alignment: Alignment.centerLeft, child: Text('Note:', style: normalText)),
            const SizedBox(height: 4),
            Text(orderNote, style: normalText),
          ],
        ),
      ),
    );
  }
}