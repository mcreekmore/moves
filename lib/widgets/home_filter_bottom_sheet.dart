import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HomeFilterBottomSheet extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    void selectedIndex(int index) async {
      if (index == 0) {
        // Submit
        // if (_fbKey.currentState.saveAndValidate()) {
        //   //print(_fbKey.currentState.value);
        //   await makePostRequest(_fbKey.currentState.value);
        //   SnackBar snackBar = SnackBar(
        //     content: Text('Location Update was sent successfully'),
        //   );

        //   Scaffold.of(_fbKey.currentContext).showSnackBar(snackBar);
        //   // Alert(
        //   //   context: context,
        //   //   title: "Thank you!",
        //   //   desc: "Your suggested place has been successfully sent.",
        //   //   image: Image.asset("assets/images/good-job.png"),
        //   // ).show();

        // }
      } else if (index == 1) {
        // Reset
        _fbKey.currentState.reset();
      } else if (index == 2) {
        // Close
        Navigator.pop(context);
      }
    }

    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Filter"),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: AppTheme.nearlyWhite,
          selectedItemColor: Colors.grey.shade800,
          selectedFontSize: 12,
          unselectedItemColor: Colors.grey.shade800,
          unselectedFontSize: 12,
          currentIndex: 0,
          onTap: (int index) {
            selectedIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.check,
                color: Colors.blueAccent,
              ),
              title: Text(
                "Accept",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.clear_all),
              title: Text('Reset'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.close, color: Colors.redAccent),
              title: Text(
                'Close',
                style: TextStyle(color: Colors.redAccent),
              ),
            )
          ]),
    );
  }
}
