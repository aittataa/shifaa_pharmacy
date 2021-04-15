import 'package:shifaa_pharmacy/constant/constant.dart';

class Brand {
  final int id;
  final String title;
  final String picture;
  final String description;

  Brand({
    this.id,
    this.title,
    this.picture,
    this.description,
  });

  factory Brand.fromJson(Map<String, dynamic> data) {
    return Brand(
      id: int.parse(data["id_brand"]),
      title: data["brand_title"],
      picture: "$URL_SERVER/images/${data["brand_picture"]}",
      description: data["brand_description"],
    );
  }
}
