import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON parser
import '../model/homelist.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moves/screens_ui/location_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:moves/model/google_home_list.dart';
import 'package:moves/model/types_model.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

//import 'package:permission_handler/permission_handler.dart';
//fixes indefinite loading for ios (delayed access prompt) (NOPE)

class Store with ChangeNotifier {
  Store() {
    initData();
  }

  /// STATE
  final FirebaseAuth _auth = FirebaseAuth.instance; // user info
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser signedInUser;
  String userID;
  String userEmail;
  List<HomeListItem> homeList = [];
  List<HomeListItem> filteredLocations = [];
  List<GoogleHomeList> googleHomeList = [];
  List<LocationLoadedModel> locations = [];
  LatLng usersLocation = LatLng(0, 0);
  LatLng usersManualLocation = LatLng(0, 0);
  bool manualLocationSelected = false;
  String placesAPIKeyAndroid = 'AIzaSyBhgIifdX2YAvcIUGOksAyYJM40BzITYdQ';
  final GoogleMapsPlaces places =
      GoogleMapsPlaces(apiKey: "AIzaSyBhgIifdX2YAvcIUGOksAyYJM40BzITYdQ");
  List<PlacesSearchResult> googleLocationResults;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LocationType typeFilter = LocationType.all;
  List<String> types = [
    "Restaurant",
    "Hotel",
    "Bar",
    "Cafe",
    "Music Venue",
    "Grocery",
    "Gas Station",
    "Bank",
    "Post Office",
    "Hospital",
    "Pharmacy",
    //"Retail"
  ];

  List<String> filteredTypes = [];

  /* API */
  static String api = 'creekmore.io'; // prod
  static String htp = 'https://'; // prod
  //static String htp = 'http://'; // dev
  //static String api = '10.0.2.2:3000'; // windows dev
  //static String api = 'localhost:3000'; // mac dev

  var uri = Uri.http(api, '/api');

  //var uriGet = Uri.https(api, '/api/locations/approved');

  /// GETTERS
  String getApi() {
    return api;
  }

  String getHttp() {
    return htp;
  }

  FirebaseAuth getAuth() {
    return _auth;
  }

  /// MUTATORS

  void filterLocations(string) {
    filteredLocations = homeList
        .where(
            (i) => i.location.name.toLowerCase().contains(string.toLowerCase()))
        .toList();
    //print(filteredLocations[0].location.name.toString());

    notifyListeners();
  }

  void filterTypes(LocationType type) {
    filteredLocations = homeList;
    if (type == LocationType.restaurant) {
      filteredLocations = filteredLocations
          .where((i) => i.location.types.contains('Restaurant'))
          .toList();
    } else if (type == LocationType.hotel) {
      filteredLocations = filteredLocations
          .where((i) => i.location.types.contains('Hotel'))
          .toList();
    } else if (type == LocationType.bar) {
      filteredLocations = filteredLocations
          .where((i) => i.location.types.contains('Bar'))
          .toList();
    } else if (type == LocationType.cafe) {
      filteredLocations = filteredLocations
          .where((i) => i.location.types.contains('Cafe'))
          .toList();
    } else if (type == LocationType.music_venue) {
      filteredLocations = filteredLocations
          .where((i) => i.location.types.contains('Music Venue'))
          .toList();
    } else if (type == LocationType.grocery) {
      filteredLocations = filteredLocations
          .where((i) => i.location.types.contains('Grocery'))
          .toList();
    } else if (type == LocationType.gas_station) {
      filteredLocations = filteredLocations
          .where((i) => i.location.types.contains('Gas Station'))
          .toList();
    } else if (type == LocationType.bank) {
      filteredLocations = filteredLocations
          .where((i) => i.location.types.contains('Bank'))
          .toList();
    } else if (type == LocationType.post_office) {
      filteredLocations = filteredLocations
          .where((i) => i.location.types.contains('Post Office'))
          .toList();
    } else if (type == LocationType.pharmacy) {
      filteredLocations = filteredLocations
          .where((i) => i.location.types.contains('Pharmacy'))
          .toList();
    } else if (type == LocationType.retail) {
      filteredLocations = filteredLocations
          .where((i) => i.location.types.contains('Retail'))
          .toList();
    } else if (type == LocationType.all) {
      filteredLocations = homeList;
    }

    notifyListeners();
  }

  void resetFilterTypes() {
    filteredLocations = homeList;
    notifyListeners();
  }

  void changeTypeFilter(type) {
    typeFilter = type;
  }

  void setUsersManualLocation(lat, lon) async {
    usersManualLocation.latitude = lat;
    usersManualLocation.longitude = lon;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('manualLat', lat);
    prefs.setDouble('manualLon', lon);
  }

  void toggleManualLocation() async {
    manualLocationSelected = !manualLocationSelected;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('manualLocSelected', manualLocationSelected);

    notifyListeners();
  }

  /// METHODS

  Future initData() async {
    await getCurrentLocation();
    //await getGoogleLocationData();
    await getUserPersistentData();
    await getData();
    filteredTypes = types;
  }

  Future<void> getUserPersistentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userID') && prefs.containsKey('userID')) {
      userID = prefs.getString('userID');
      userEmail = prefs.getString('userEmail');
    } else {
      userID = null;
      userEmail = null;
    }

    if (prefs.containsKey('manualLocSelected')) {
      manualLocationSelected = prefs.getBool('manualLocSelected');
    }

    if (prefs.containsKey('manualLat') && prefs.containsKey('manualLat')) {
      usersManualLocation.latitude = prefs.getDouble('manualLat');
      usersManualLocation.longitude = prefs.getDouble('manualLon');
    }
    notifyListeners();
  }

  // Future<void> getGoogleLocationData() async {
  //   PlacesSearchResponse response = await places.searchNearbyWithRadius(
  //       Location(usersLocation.latitude, usersLocation.longitude), 1500);
  //   googleLocationResults = response.results;
  // }

  Future<dynamic> getUserFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    FirebaseUser signedInUserPref = prefs.get('signedInUserPref');
    if (signedInUserPref == null) {
      return null;
    }
    return signedInUserPref;
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

        locations.add(LocationLoadedModel(
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
          updateInfo: location["update_info"],
          userID: location["user_id"],
        ));
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

    if (manualLocationSelected) {
      final double distanceCalced =
          distance.as(LengthUnit.Kilometer, locationCoord, usersManualLocation);
      return distanceCalced;
    } else {
      final double distanceCalced =
          distance.as(LengthUnit.Kilometer, locationCoord, usersLocation);
      return distanceCalced;
    }
  }

  void buildHomeList(locations) {
    homeList = [];
    for (var location in locations) {
      homeList.add(
        HomeListItem(
          imagePath:
              'assets/icons/${location.types[0].toString().toLowerCase()}.png',
          navigateScreen: LocationScreen(
            location: location,
          ),
          location: location,
        ),
      );
    }
    filteredLocations = homeList;
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
    //print(signedInUser);
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

      // setters
      signedInUser = user;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userID', user.uid);
      userID = user.uid;
      prefs.setString('userEmail', user.email);
      userEmail = user.email;
      notifyListeners();
      await currentUser.getIdToken().then((IdTokenResult tokenResult) {
        print(tokenResult.token);
        prefs.setString('token', tokenResult.token);
      });

      return 'signInWithGoogle succeeded: ${user.email}';
    } catch (e) {
      print(e);
    }
    return 'error';
  }

  Future<void> signInApple() async {
    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        print("print: ${result.credential.user}");

        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider(providerId: 'apple.com');
        final credential = oAuthProvider.getCredential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );
        final authResult = await _auth.signInWithCredential(credential);
        final user = authResult.user;

        // Store user ID
        // await FlutterSecureStorage()
        //     .write(key: "userId", value: result.credential.user);

        // setters
        signedInUser = user;
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userID', user.uid);
        userID = user.uid;
        prefs.setString('userEmail', user.email);
        userEmail = user.email;
        notifyListeners();
        await user.getIdToken().then((IdTokenResult tokenResult) {
          print(tokenResult.token);
          prefs.setString('token', tokenResult.token);
        });
        break;

      case AuthorizationStatus.error:
        print("Sign in failed: ${result.error.localizedDescription}");
        // setState(() {
        //   errorMessage = "Sign in failed";
        // });
        break;
    }
  }

  Future<void> signInEmail(FirebaseUser user) async {
    // setters
    signedInUser = user;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', user.uid);
    userID = user.uid;
    prefs.setString('userEmail', user.email);
    userEmail = user.email;
    notifyListeners();
    await user.getIdToken().then((IdTokenResult tokenResult) {
      print(tokenResult.token);
      prefs.setString('token', tokenResult.token);
    });
  }

  void signOutGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await googleSignIn.signOut(); // signs out both regardless of sign in choice
    await _auth.signOut();
    signedInUser = null;
    userEmail = null;
    userID = null;
    prefs.remove('userEmail');
    prefs.remove('userID');
    notifyListeners();
  }
}
