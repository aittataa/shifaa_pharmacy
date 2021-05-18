import 'package:shifaa_pharmacy/constant/constant.dart';

// List<Product> productFromJson(String str) {
//   return List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
// }

class Product {
  final int id;
  final String name;
  final String tradeName;
  final String mainIngredient;
  final String dose;
  final int quantity;
  final double price;
  final String picture;
  final bool featured;
  final bool status;
  final String description;
  final String dosageType;
  final int medicineID;
  final String medicineTitle;
  final int subcategoryID;
  final String subcategoryTitle;
  final int brandID;
  final String brandTitle;
  //final bool isFav;
  final int isShop;

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
    this.dosageType,
    this.medicineID,
    this.medicineTitle,
    this.subcategoryID,
    this.subcategoryTitle,
    this.brandID,
    this.brandTitle,
    //this.isFav,
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
      picture: "${Constant.SERVER_URL}/images/${data["picture"]}",
      featured: data["featured"] == "1",
      status: data["status"] == "1",
      description: data["description"],
      dosageType: data["dosageform_type"] ?? null,
      medicineID: data["id_medcategory"] != null ? int.parse(data["id_medcategory"]) : 0,
      medicineTitle: data["medcategory_title"] ?? null,
      subcategoryID: data["id_subcategory"] != null ? int.parse(data["id_subcategory"]) : 0,
      subcategoryTitle: data["subcategory_title"] ?? null,
      brandID: data["id_subcategory"] != null ? int.parse(data["id_brand"]) : 0,
      brandTitle: data["brand_title"] ?? null,
      //isFav: data["favorite_status"] == "1" ?? false,
      isShop: int.parse(data["shop"]),
    );
  }
}
