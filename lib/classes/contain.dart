class Contain {
  final int id;
  final int productID;
  final String productName;
  final double productPrice;
  final int orderID;

  Contain({
    this.id,
    this.productID,
    this.productName,
    this.productPrice,
    this.orderID,
  });

  factory Contain.fromJson(Map<String, dynamic> data) {
    return Contain(
      id: int.parse(data["id_contain"]),
      productID: int.parse(data["product_id"]),
      productName: data["name"],
      productPrice: double.parse(data["price"]),
      orderID: int.parse(data["order_id"]),
    );
  }
}
