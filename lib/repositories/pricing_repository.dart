enum SandwichSize { sixInch, footlong }

class PricingRepository {
  final double sixInchPrice;
  final double footlongPrice;

  PricingRepository({this.sixInchPrice = 7.0, this.footlongPrice = 11.0});

  double totalPrice({required int quantity, required SandwichSize size}) {
    final unit = size == SandwichSize.footlong ? footlongPrice : sixInchPrice;
    return unit * quantity;
  }
}
