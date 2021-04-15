import 'package:shifaa_pharmacy/constant/constant.dart';

class Product {
  int id;
  String name;
  String tradeName;
  String mainIngredient;
  String dose;
  int quantity;
  double price;
  String picture;
  bool featured;
  bool status;
  String description;
  String dosage_form_type;
  String medicine_category_title;
  String subcategory_title;
  String brand_title;
  bool isFav;
  int isShop;

  Product({
    this.id,
    this.name,
    this.tradeName,
    this.mainIngredient,
    this.dose,
    this.quantity,
    this.price,
    this.picture,
    this.featured,
    this.status,
    this.description,
    this.dosage_form_type,
    this.medicine_category_title,
    this.subcategory_title,
    this.brand_title,
    this.isFav,
    this.isShop,
  });

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      id: int.parse(data["id_product"]),
      name: data["name"] ?? null,
      tradeName: data["trade_name"] ?? null,
      mainIngredient: data["main_ingredient"] ?? null,
      dose: data["dose"] ?? null,
      quantity: int.parse(data["quantity"]) ?? 0,
      price: double.parse(data["price"]),
      picture: "$URL_SERVER/images/${data["picture"]}",
      featured: data["featured"] == "1",
      status: data["status"] == "1",
      description: data["description"],
      dosage_form_type: data["dosageform_type"] ?? null,
      medicine_category_title: data["medcategory_title"] ?? null,
      subcategory_title: data["subcategory_title"] ?? null,
      brand_title: data["brand_title"] ?? null,
      isFav: data["favorite_status"] == "1" ?? false,
      isShop: int.parse(data["shop"]),
    );
  }
}
