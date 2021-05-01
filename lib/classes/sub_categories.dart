import 'package:shifaa_pharmacy/constant/constant.dart';

class SubCategories {
  final int id;
  final String title;
  final String picture;
  final String description;
  final int categoryID;

  SubCategories({
    this.id,
    this.title,
    this.picture,
    this.description,
    this.categoryID,
  });

  factory SubCategories.fromJson(Map<String, dynamic> data) {
    return SubCategories(
      id: int.parse(data["id_subcategory"]),
      title: data["subcategory_title"],
      picture: "${Constant.SERVER_URL}/images/${data["subcategory_picture"]}",
      description: data["subcategory_description"],
      categoryID: int.parse(data["category_id"]),
    );
  }
}
