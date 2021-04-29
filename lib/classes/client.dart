import 'package:shifaa_pharmacy/constant/constant.dart';

class Client {
  final int id;
  final String username;
  final String email;
  final String password;
  final String phone;
  final String picture;
  final String profile;
  final String address;
  final int zipCode;
  final String city;

  Client({
    this.id,
    this.username,
    this.email,
    this.password,
    this.phone,
    this.picture,
    this.profile,
    this.address,
    this.zipCode,
    this.city,
  });

  factory Client.fromJson(Map<String, dynamic> data) {
    return Client(
      id: int.parse(data["id"]),
      username: data["full_name"],
      email: data["email"],
      password: data["password"],
      phone: data["phone"],
      picture: "$URL_SERVER/images/${data["picture"]}",
      address: data["address"],
      zipCode: data["zip_code"] != null ? int.parse(data["zip_code"]) : 0,
      city: data["city"],
    );
  }
}
