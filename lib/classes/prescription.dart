import 'package:shifaa_pharmacy/constant/constant.dart';

class Prescription {
  final int id;
  final String picture;
  final String file;
  final String description;
  final DateTime date;
  final int order_id;

  Prescription({
    this.id,
    this.picture,
    this.file,
    this.description,
    this.date,
    this.order_id,
  });

  factory Prescription.fromJson(Map<String, dynamic> data) {
    return Prescription(
      id: int.parse(data["id_prescription"]),
      picture: "$URL_SERVER/images/prescriptions/${data["prescription_picture"]}",
      description: data["prescription_description"],
      date: DateTime.parse(data["prescription_date"]),
      order_id: int.parse(data["order_id"]),
    );
  }
}
