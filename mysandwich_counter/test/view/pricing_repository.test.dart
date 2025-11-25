// ...existing code...
class PricingRepository {
  static const double _priceSixInch = 7.0;
  static const double _priceFootlong = 11.0;

  double calculateTotalPrice({
    required int quantity,
    required bool isFootlong,
  }) {
    if (quantity <= 0) return 0.0;
    final unitPrice = isFootlong ? _priceFootlong : _priceSixInch;
    return unitPrice * quantity;
  }

  // Backwards-compatible alias used by existing tests/code
  double calculateTotal({
    required int quantity,
    required bool isFootlong,
  }) =>
      calculateTotalPrice(quantity: quantity, isFootlong: isFootlong);
}
// ...existing code...