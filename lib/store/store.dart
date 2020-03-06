import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moves/app_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON parser
import '../model/homelist.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moves/screens_ui/location_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:moves/screens_ui/google_location_screen.dart';
import 'package:moves/model/google_home_list.dart';

class Store with ChangeNotifier {
  Store() {
    initData();
  }

  /// STATE
  AppTheme appTheme = AppTheme();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser signedInUser;
  List<HomeList> homeList = [];
  List<GoogleHomeList> googleHomeList = [];
  List<LocationLoadedModel> locations = [];
  LatLng usersLocation = LatLng(0, 0);
  String placesAPIKeyAndroid = 'AIzaSyBhgIifdX2YAvcIUGOksAyYJM40BzITYdQ';
  final GoogleMapsPlaces places =
      GoogleMapsPlaces(apiKey: "AIzaSyBhgIifdX2YAvcIUGOksAyYJM40BzITYdQ");
  List<PlacesSearchResult> googleLocationResults;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /* API */
  //static String api = 'creekmore.io'; // prod
  static String api = '10.0.2.2:3000'; // dev
  var uri = Uri.http(api, '/api');

  //var uriGet = Uri.https(api, '/api/locations/approved');

  /// GETTERS
  String getApi() {
    return api;
  }

  /// MUTATORS

  /// METHODS

  Future initData() async {
    await getCurrentLocation();
    await getGoogleLocationData();
    await getData();
  }

  Future<void> getGoogleLocationData() async {
    PlacesSearchResponse response = await places.searchNearbyWithRadius(
        Location(usersLocation.latitude, usersLocation.longitude), 1500);
    googleLocationResults = response.results;
  }

  Future<dynamic> getUserFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    FirebaseUser signedInUserPref = prefs.get('signedInUserPref');
    if (signedInUserPref == null) {
      return null;
    }
    return signedInUserPref;
  }

  Future<void> signOutUserSharedPref() async {
    //final prefs = await SharedPreferences.getInstance();
    //await prefs.set
  }

  Future<List<LocationLoadedModel>> getData() async {
    http.Response response =
        await http.get(uri.toString() + '/locations/approved');

    if (response.statusCode == 200) {
      var data = response.body;
      locations = [];

      List<dynamic> unparsedLocations = jsonDecode(data);
      for (var location in unparsedLocations) {
        double distance = calcDistance(location);

        locations.add(
          LocationLoadedModel(
              id: location["_id"],
              name: location["name"],
              description: location["description"],
              types: location["types"],
              country: location["country"],
              region: location["region"],
              city: location["city"],
              street: location["street"],
              zip: location["zip"],
              lat: location["lat"],
              lon: location["lon"],
              email: location["email"],
              phone: location["phone"],
              website: location["website"],
              distance: distance.toDouble(),
              updateInfo: location["update_info"]),
        );
      }

      sortLocations(locations);

      buildHomeList(locations);

      notifyListeners();
      return locations;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  void sortLocations(List<LocationLoadedModel> locations) {
    locations.sort((a, b) => a.distance.compareTo(b.distance));
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double _latitude = position.latitude;
      double _longitude = position.longitude;

      usersLocation = LatLng(_latitude, _longitude);
    } catch (e) {
      print(e);
    }
  }

  double calcDistance(location) {
    final Distance distance = new Distance();

    LatLng locationCoord =
        LatLng(location["lat"].toDouble(), location["lon"].toDouble());

    final double distanceCalced =
        distance.as(LengthUnit.Kilometer, locationCoord, usersLocation);

    return distanceCalced;
  }

  void buildHomeList(locations) {
    homeList = [];
    for (var location in locations) {
      homeList.add(
        HomeList(
          imagePath:
              'assets/icons/${location.types[0].toString().toLowerCase()}.png',
          navigateScreen: LocationScreen(
            location: location,
          ),
          location: location,
        ),
      );
    }
  }

  void buildGoogleHomeList(locations) {
    googleHomeList = [];
    for (var location in locations) {
      googleHomeList.add(
        GoogleHomeList(
          imagePath: 'assets/icons/bar.png',
          navigateScreen: GoogleLocationScreen(
            location: location,
          ),
          location: location,
        ),
      );
    }
    print(googleHomeList.length);
  }

  Future<String> signInWithEmail({String email, String password}) async {
    try {
      final AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      signedInUser = await _auth.currentUser();

      return result.toString();
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> signInWithGoogle() async {
    print(signedInUser);
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      signedInUser = user;
      notifyListeners();

      return 'signInWithGoogle succeeded: ${user.email}';
    } catch (e) {
      print(e);
    }
    return 'error';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut(); // signs out both regardless of sign in choice
    await _auth.signOut();
    signedInUser = null;
    notifyListeners();
  }
}
