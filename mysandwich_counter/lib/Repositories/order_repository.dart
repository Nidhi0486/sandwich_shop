class PricingRepository {
  /// Returns the price of the sandwich based on size.
  /// six-inch  → $5.00
  /// footlong  → $8.50
  double getSizePrice({required bool isFootlong}) {
    return isFootlong ? 8.50 : 5.00;
  }

  /// Returns additional price if the sandwich is toasted.
  /// toasted   → $0.50
  /// untoasted → $0.00
  double getToastedPrice({required bool isToasted}) {
    return isToasted ? 0.50 : 0.0;
  }

  /// Returns the total price combining size + toasted.
  double getTotalPrice({
    required bool isFootlong,
    required bool isToasted,
  }) {
    return getSizePrice(isFootlong: isFootlong) +
        getToastedPrice(isToasted: isToasted);
  }
}
