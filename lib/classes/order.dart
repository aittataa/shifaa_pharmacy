class Order {
  final int id;
  final DateTime dateOrder;
  final bool isValid;
  final double total;
  final String type;
  final int clientID;

  Order({
    this.id,
    this.dateOrder,
    this.isValid = false,
    this.type,
    this.total,
    this.clientID,
  });

  factory Order.fromJson(Map<String, dynamic> data) {
    return Order(
      id: int.parse(data["id_order"]),
      dateOrder: DateTime.parse(data["order_date"]),
      isValid: data["order_status"] == "1",
      type: data["order_type"],
      total: data["total"] != null ? double.parse(data["total"]) : 0,
    );
  }
}
