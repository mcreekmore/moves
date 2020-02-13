class LocationPostModel {
  String name;
  String description;
  List<String> types; //TODO implement multiple
  String country;
  String region;
  String city;
  String street;
  String zip;
  double lat;
  double lon;
  String email;
  String phone;
  String website;

  LocationPostModel({
    this.name,
    this.description,
    this.types,
    this.country,
    this.region,
    this.city,
    this.street,
    this.zip,
    this.lat,
    this.lon,
    this.email,
    this.phone,
    this.website,
  });
}
