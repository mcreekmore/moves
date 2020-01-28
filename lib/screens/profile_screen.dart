import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          MaterialButton(
            child: Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
            minWidth: 180,
            onPressed: () {},
          ),
          MaterialButton(
            child: Text('Sign In with Google',
                style: TextStyle(color: Colors.white)),
            color: Colors.blue,
            minWidth: 180,
            onPressed: () {
              Provider.of<Store>(context, listen: false)
                  .signInWithGoogle()
                  .whenComplete(() {
                print('Signed in with google');
              });
            },
          ),
          MaterialButton(
            child: Text('Sign Out', style: TextStyle(color: Colors.white)),
            color: Colors.red,
            minWidth: 180,
            onPressed: () {
              Provider.of<Store>(context, listen: false).signOutGoogle();
            },
          ),
        ],
      ),
    );
  }
}
