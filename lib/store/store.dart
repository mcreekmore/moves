import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moves/app_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON parser
import '../model/homelist.dart';
//import 'package:moves/model/location_post_model.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moves/screens_ui/location_screen.dart';
import 'package:moves/screens_ui/test_screen.dart';

//import 'dart:collection';

class Store with ChangeNotifier {
  Store() {
    initData();
  }
  AppTheme appTheme = AppTheme();
  // development uri
  //var uri = Uri.http('10.0.2.2:3000', '/api/locations/approved');

  // prod uri
  var uri = Uri.http('creekmore.io', '/api/locations/approved');

  // state
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser signedInUser;
  List<HomeList> homeList = [];
  List<LocationLoadedModel> locations = [];
  LatLng usersLocation = LatLng(0, 0);

  // getters

  // mutators

  // methods

  Future initData() async {
    await getCurrentLocation();
    await getData();
  }

  Future<List<LocationLoadedModel>> getData() async {
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = response.body;
      //print(data);

      //return jsonDecode(data); // this should ALWAYS be dynamic

      List<dynamic> unparsedLocations = jsonDecode(data);
      //print(locations);
      for (var location in unparsedLocations) {
        double distance = calcDistance(location);

        locations.add(
          LocationLoadedModel(
            name: location["name"],
            description: location["description"],
            type: location["type"],
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
          ),
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
      print(position);
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
              'assets/icons/${location.type.toString().toLowerCase()}.png',
          // navigateScreen: LocationScreen(
          //   location: location,
          // ),
          navigateScreen: LocationScreen(
            location: location,
          ),
          location: location,
        ),
      );
    }

    //print(homeList);
    //return homeList;
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

      //print('signInWithGoogle succeeded: ${user.email}');
      signedInUser = user;
      //print(signedInUser);

      return 'signInWithGoogle succeeded: ${user.email}';
    } catch (e) {
      print(e);
    }
    return 'error';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut(); // signs out both regardless of sign in choice
    await _auth.signOut();
    print("User Sign Out");
  }
}
