// Simple Dart console version — no Flutter dependency
void main() {
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

  print('Sandwich Counter\n');

  for (var index = 0; index < 20; index++) {
    final type = sandwichTypes[index % sandwichTypes.length];
    final quantity = (index % 6) + 1;
    printOrderItem(quantity, type);
  }
}

void printOrderItem(int quantity, String itemType) {
  // Print a simple textual representation, using emoji for sandwiches
  final sandwiches = List.filled(quantity, '🥪').join();
  print('$quantity $itemType sandwich(es): $sandwiches');
}