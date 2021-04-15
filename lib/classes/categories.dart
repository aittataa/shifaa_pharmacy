import 'package:shifaa_pharmacy/constant/constant.dart';

class Categories {
  final int id;
  final String title;
  final String picture;
  final String description;

  Categories({
    this.id,
    this.title,
    this.picture,
    this.description,
  });

  factory Categories.fromJson(Map<String, dynamic> data) {
    return Categories(
      id: int.parse(data["id_category"]),
      title: data["category_title"],
      picture: "$URL_SERVER/images/${data["category_picture"]}",
      description: data["category_description"],
    );
  }
}
