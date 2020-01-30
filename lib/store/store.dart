import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moves/app_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON parser
import '../model/homelist.dart';

//import 'dart:collection';

class Store with ChangeNotifier {
  Store();
  AppTheme appTheme = AppTheme();
  // development uri
  var uri = Uri.http('10.0.2.2:3000', '/api/locations/approved');

  // prod uri
  // var uri = Uri.http('creekmore.io', '/api/locations/approved');

  // state
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser signedInUser;
  List<HomeList> homeList = [];
  // getters

  // mutators

  // methods

  Future<dynamic> getData() async {
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = response.body;
      //print(data);

      return jsonDecode(data); // this should ALWAYS be dynamic
    } else {
      print(response.statusCode);
      return response.statusCode;
    }
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
