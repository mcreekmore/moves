// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moves/screens_ui/register_email.dart';
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInEmail extends StatefulWidget {
  final String title = 'Email Sign In';
  @override
  State<StatefulWidget> createState() => SignInEmailState();
}

class SignInEmailState extends State<SignInEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // actions: <Widget>[
        //   Builder(builder: (BuildContext context) {
        //     return FlatButton(
        //       child: const Text('Sign out'),
        //       textColor: Theme.of(context).buttonColor,
        //       onPressed: () async {
        //         final FirebaseUser user = await _auth.currentUser();
        //         if (user == null) {
        //           Scaffold.of(context).showSnackBar(const SnackBar(
        //             content: Text('No one has signed in.'),
        //           ));
        //           return;
        //         }
        //         _signOut();
        //         final String uid = user.uid;
        //         Scaffold.of(context).showSnackBar(SnackBar(
        //           content: Text(uid + ' has successfully signed out.'),
        //         ));
        //       },
        //     );
        //   })
        // ],
      ),
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(child: _EmailPasswordForm());
      }),
    );
  }

  // Example code for sign out.
  void _signOut() async {
    await _auth.signOut();
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child:
                  const Text('Sign in to Moves with your email and password'),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 16.0),
            //   alignment: Alignment.center,
            //   child: RaisedButton(
            //     onPressed: () async {
            //       if (_formKey.currentState.validate()) {
            //         _signInWithEmailAndPassword();
            //       }
            //     },
            //     child: const Text('Submit'),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      RegisterPage()),
                            );
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              _signInWithEmailAndPassword();
                            }
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _success == null
                    ? ''
                    : (_success
                        ? 'Successfully signed in ' + _userEmail
                        : 'Sign in failed'),
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // sign in with email and password.
  void _signInWithEmailAndPassword() async {
    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ))
          .user;

      if (user != null) {
        await Provider.of<Store>(context, listen: false).signInEmail(user);
        setState(() {
          _success = true;
          _userEmail = user.email;
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
    } catch (e) {
      setState(() {
        _success = false;
      });
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:moves/store/store.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';

// class SignInEmail extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         //backgroundColor: AppTheme.nearlyWhite,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 32),
//                   child: Text(
//                     'Sign in with Email',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 // form
//                 FormBuilder(
//                   //key: _suggestKey,
//                   autovalidate: true,
//                   child: Column(
//                     children: <Widget>[
//                       FormBuilderTextField(
//                         attribute: "email",
//                         decoration: InputDecoration(labelText: "Email"),
//                         validators: [
//                           FormBuilderValidators.maxLength(300),
//                         ],
//                       ),
//                       FormBuilderTextField(
//                         attribute: "password",
//                         obscureText: true,
//                         maxLines: 1,
//                         decoration: InputDecoration(labelText: "Password"),
//                         validators: [
//                           FormBuilderValidators.maxLength(300),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//   child: Center(
//     child: Container(
//       width: 100,
//       height: 40,
//       decoration: BoxDecoration(
//         color: Colors.red,
//         borderRadius:
//             const BorderRadius.all(Radius.circular(4.0)),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Icon(
//                   Icons.arrow_back,
//                   color: Colors.white,
//                   size: 22,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Text(
//                     'Back',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   ),
// ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Center(
//                         child: Container(
//                           width: 100,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: Colors.green,
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(4.0)),
//                           ),
//                           child: Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               onTap: () {},
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: <Widget>[
//                                     Icon(
//                                       Icons.person,
//                                       color: Colors.white,
//                                       size: 22,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(4.0),
//                                       child: Text(
//                                         'Sign In',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
