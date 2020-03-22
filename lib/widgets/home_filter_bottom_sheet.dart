import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:moves/app_theme.dart';
import 'package:moves/store/store.dart';

class HomeFilterBottomSheet extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // List<String> initialValues =
    //     Provider.of<Store>(context, listen: false).filteredTypes;

    void selectedIndex(int index) async {
      if (index == 0) {
        // Submit
        print(_fbKey.currentState.value);
        if (_fbKey.currentState.value["type"] != null) {
          // Provider.of<Store>(context, listen: false)
          //     .filterTypes(_fbKey.currentState.value["type"]);
          Navigator.pop(context);
        } else {
          //Provider.of<Store>(context, listen: false).resetFilterTypes();
          Navigator.pop(context);
        }
      } else if (index == 1) {
        // Cancel
        Navigator.pop(context);
      }
    }

    return Scaffold(
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("Filter"),
              FormBuilder(
                key: _fbKey,
                autovalidate: true,
                initialValue: {"type": "Bar"},
                child: Column(
                  children: <Widget>[
                    // types
                    FormBuilderChoiceChip(
                      attribute: "type",
                      options: [
                        FormBuilderFieldOption(
                          child: Text("Restaurant"),
                          value: "Restaurant",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Hotel"),
                          value: "Hotel",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Bar"),
                          value: "Bar",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Cafe"),
                          value: "Cafe",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Music Venue"),
                          value: "Music Venue",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Grocery"),
                          value: "Grocery",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Gas Station"),
                          value: "Gas Station",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Bank"),
                          value: "Bank",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Post Office"),
                          value: "Post Office",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Pharmacy"),
                          value: "Pharmacy",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Retail"),
                          value: "Retail",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Hospital"),
                          value: "Hospital",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppTheme.nearlyWhite,
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
                Icons.check_circle,
                color: Colors.blueAccent,
              ),
              title: Text(
                "Accept",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cancel, color: Colors.redAccent),
              title: Text(
                'Cancel',
                style: TextStyle(color: Colors.redAccent),
              ),
            )
          ]),
    );
  }
}
