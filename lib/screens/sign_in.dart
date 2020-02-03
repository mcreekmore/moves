import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:moves/app_theme.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.1),
                        //color: AppTheme().getDrawerIconShadow(),
                        //offset: const Offset(2.0, 4.0),
                        blurRadius: 8),
                  ],
                ),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: CircleAvatar(
                  radius: 150,
                  backgroundImage: AssetImage('assets/images/m.png'),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'Sign In to Moves',
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
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: const Offset(4, 4),
                            blurRadius: 8.0),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 22,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Sign In With Moves',
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
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: 210,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: const Offset(4, 4),
                            blurRadius: 8.0),
                      ],
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
                                Icons.share,
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
              )
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
