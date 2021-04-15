class Settings {
  final int id;
  final bool skip;
  final String version;
  final String description;
  final String policy;
  final String name;
  final String contact;
  final String email;
  final String website;
  final String address;

  Settings({
    this.id,
    this.skip,
    this.version,
    this.description,
    this.policy,
    this.name,
    this.contact,
    this.email,
    this.website,
    this.address,
  });

  factory Settings.fromJson(Map<String, dynamic> data) {
    return Settings(
      id: int.parse(data["id"]),
      version: data["app_version"],
      description: data["app_description"],
      policy: data["app_privacy_policy"],
      name: data["company_name"],
      contact: data["company_contact"],
      email: data["company_email"],
      website: data["company_website"],
      address: data["company_address"],
    );
  }
}
