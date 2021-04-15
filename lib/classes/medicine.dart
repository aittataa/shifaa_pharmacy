import 'package:shifaa_pharmacy/constant/constant.dart';

class Medicine {
  final int id;
  final String title;
  final String picture;
  final String description;

  Medicine({
    this.id,
    this.title,
    this.picture,
    this.description,
  });

  factory Medicine.fromJson(Map<String, dynamic> data) {
    return Medicine(
      id: int.parse(data["id_medcategory"]),
      title: data["medcategory_title"],
      picture: "$URL_SERVER/images/${data["medcategory_picture"]}",
      description: data["medcategory_description"],
    );
  }
}
