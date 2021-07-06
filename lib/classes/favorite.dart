class Favorite {
  final int id;
  final int clientID;
  final int productID;
  final DateTime dateCreation;
  final int status;

  Favorite({
    this.id,
    this.clientID,
    this.productID,
    this.dateCreation,
    this.status,
  });

  factory Favorite.fromJson(Map<String, dynamic> data) {
    return Favorite(
      id: int.parse(data["id_favorite"]),
      clientID: int.parse(data["client_id"]),
      productID: int.parse(data["product_id"]),
      dateCreation: DateTime.parse(data["date_creation"]),
      status: int.parse(data["favorite_status"]),
    );
  }
}
