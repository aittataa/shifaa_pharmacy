import 'package:shifaa_pharmacy/constant/constant.dart';

class SubCategories {
  final int id;
  final String title;
  final String picture;
  final String description;
  final int category_id;

  SubCategories({
    this.id,
    this.title,
    this.picture,
    this.description,
    this.category_id,
  });

  factory SubCategories.fromJson(Map<String, dynamic> data) {
    return SubCategories(
      id: int.parse(data["id_subcategory"]),
      title: data["subcategory_title"],
      picture: "$URL_SERVER/images/${data["subcategory_picture"]}",
      description: data["subcategory_description"],
      category_id: int.parse(data["category_id"]),
    );
  }
}
