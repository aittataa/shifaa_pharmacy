import 'package:shifaa_pharmacy/constant/constant.dart';

class Prescription {
  final int id;
  final String picture;
  final String file;
  final String description;
  final DateTime date;
  final int orderID;

  Prescription({
    this.id,
    this.picture,
    this.file,
    this.description,
    this.date,
    this.orderID,
  });

  factory Prescription.fromJson(Map<String, dynamic> data) {
    return Prescription(
      id: int.parse(data["id_prescription"]),
      picture: "${Constant.SERVER_URL}/images/prescriptions/${data["prescription_picture"]}",
      description: data["prescription_description"],
      date: DateTime.parse(data["prescription_date"]),
      orderID: int.parse(data["order_id"]),
    );
  }
}
