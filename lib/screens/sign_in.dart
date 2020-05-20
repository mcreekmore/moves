import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:moves/screens_ui/sign_in_email.dart';
import 'dart:io';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void logInApple() async {
      Provider.of<Store>(context, listen: false).signInApple();
    }

    return Container(
      //color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Sign In'),
          ),
          //backgroundColor: AppTheme.nearlyWhite,
          body: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //       //color: AppTheme.grey.withOpacity(0.1),
                  //       //color: AppTheme().getDrawerIconShadow(),
                  //       //offset: const Offset(2.0, 4.0),
                  //       blurRadius: 8),
                  // ],
                ),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/m.png'),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Center(
                  child: Container(
                    width: 210,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green,
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
                                    SignInEmail()),
                          );
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 22,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Sign In With Email',
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
              Center(
                child: Container(
                  width: 210,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Provider.of<Store>(context, listen: false)
                            .signInWithGoogle()
                            .whenComplete(() {
                          //print('Signed in with google');

                          Navigator.pop(context);
                        });
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 22,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Sign In With Google',
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
              Platform.isIOS
                  ? Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Center(
                        child: Container(
                          width: 210,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                // Provider.of<Store>(context, listen: false)
                                //     .signInWithGoogle()
                                //     .whenComplete(() {
                                //
                                // });
                                logInApple();
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Sign In With Apple',
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
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

//     return Scaffold(
//       backgroundColor: AppTheme.nearlyWhite,
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               width: double.infinity,
//             ),
//             MaterialButton(
//               child: Text(
//                 'Sign In',
//                 style: TextStyle(color: Colors.white),
//               ),
//               color: Colors.green,
//               minWidth: 180,
//               onPressed: () {},
//             ),
//             MaterialButton(
//               child: Text('Sign In with Google',
//                   style: TextStyle(color: Colors.white)),
//               color: Colors.blue,
//               minWidth: 180,
//               onPressed: () {
//                 Provider.of<Store>(context, listen: false)
//                     .signInWithGoogle()
//                     .whenComplete(() {
//                   print('Signed in with google');
//                 });
//               },
//             ),
//             MaterialButton(
//               child: Text('Sign Out', style: TextStyle(color: Colors.white)),
//               color: Colors.red,
//               minWidth: 180,
//               onPressed: () {
//                 Provider.of<Store>(context, listen: false).signOutGoogle();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
