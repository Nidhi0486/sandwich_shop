/// A simple console version of the Sandwich counter so this file compiles
/// outside of a Flutter environment (e.g. plain Dart test runs).
void main() {
  final app = OrderApp(maxQuantity: 5);
  app.showStatus();
  app.increase();
  app.increase();
  app.showStatus();
  app.decrease();
  app.showStatus();
}

enum SandwichSize { sixInch, footlong }

enum BreadType { white, wholemeal, italianHerbs }

class OrderApp {
  final int maxQuantity;
  int _quantity = 0;
  SandwichSize _selectedSize = SandwichSize.sixInch;
  BreadType _selectedBread = BreadType.white;

  OrderApp({this.maxQuantity = 10});

  void increase() {
    if (_quantity < maxQuantity) {
      _quantity++;
    } else {
      print('Cannot add more than $maxQuantity items.');
    }
  }

  void decrease() {
    if (_quantity > 0) {
      _quantity--;
    } else {
      print('Quantity is already zero.');
    }
  }

  void setSize(SandwichSize size) => _selectedSize = size;

  void setBread(BreadType bread) => _selectedBread = bread;

  void showStatus() {
    final sandwichType = _selectedSize == SandwichSize.footlong ? 'Footlong' : 'Six-inch';
    final bread = _selectedBread.name;
    print('Quantity: $_quantity | Type: $sandwichType | Bread: $bread');
  }
}