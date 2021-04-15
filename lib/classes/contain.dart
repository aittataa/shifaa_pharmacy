class Contain {
  final int id;
  final int product_id;
  final String product_name;
  final double product_price;
  final int order_id;

  Contain({
    this.id,
    this.product_id,
    this.product_name,
    this.product_price,
    this.order_id,
  });

  factory Contain.fromJson(Map<String, dynamic> data) {
    return Contain(
      id: int.parse(data["id_contain"]),
      product_id: int.parse(data["product_id"]),
      product_name: data["name"],
      product_price: double.parse(data["price"]),
      order_id: int.parse(data["order_id"]),
    );
  }
}
