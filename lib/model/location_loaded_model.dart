class LocationLoadedModel {
  String id;
  String name;
  String description;
  List<dynamic> types;
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
  String userID;
  double distance;
  double openPercent;
  //update info
  dynamic updateInfo;

  LocationLoadedModel({
    this.id,
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
    this.distance,
    this.openPercent,
    this.updateInfo,
    this.userID,
  });
}
