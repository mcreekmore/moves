class Favorite {
  int id;
  String placeID;

  Favorite({this.id, this.placeID});

  factory Favorite.fromMap(Map<String, dynamic> json) => new Favorite(
        id: json["id"],
        placeID: json["placeID"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "placeID": placeID,
      };

  String getPlaceID() {
    return placeID;
  }
}
