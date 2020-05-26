import 'package:flutter/material.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:moves/model/types_model.dart';
import 'package:moves/theme_notifier.dart';

class HomeFilterBottomSheet extends StatefulWidget {
  HomeFilterBottomSheet({@required this.type});

  LocationType type;

  @override
  _HomeFilterBottomSheetState createState() => _HomeFilterBottomSheetState();
}

class _HomeFilterBottomSheetState extends State<HomeFilterBottomSheet> {
  //final GlobalKey<FormBuilderState> _fbFilterKey =
  //  GlobalKey<FormBuilderState>();
  //LocationType _typeFilter = LocationType.all;

  @override
  Widget build(BuildContext context) {
    //LocationType _typeFilter = Provider.of<Store>(context).typeFilter;

    //final LocationType _initialValue = Provider.of<Store>(context).typeFilter;
    // List<String> initialValues =
    //     Provider.of<Store>(context, listen: false).filteredTypes;
    void selectedIndex(int index) async {
      if (index == 0) {
        // Apply
        Provider.of<Store>(context, listen: false).filterTypes(widget.type);
        Navigator.pop(context);
      }

      if (index == 1) {
        // Cancel
        Navigator.pop(context);
      }
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                'Filter Type',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('All'),
                leading: Radio(
                  value: LocationType.all,
                  groupValue: widget.type,
                  onChanged: (LocationType value) {
                    setState(() {
                      widget.type = value;
                      // Provider.of<Store>(context, listen: false)
                      //     .changeTypeFilter(value);
                    });
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Bank'),
                leading: Radio(
                  value: LocationType.bank,
                  groupValue: widget.type,
                  onChanged: (LocationType value) {
                    setState(() {
                      widget.type = value;
                      // Provider.of<Store>(context, listen: false)
                      //     .changeTypeFilter(value);
                    });
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Bar'),
                leading: Radio(
                  value: LocationType.bar,
                  groupValue: widget.type,
                  onChanged: (LocationType value) {
                    setState(() {
                      widget.type = value;
                      // Provider.of<Store>(context, listen: false)
                      //     .changeTypeFilter(value);
                    });
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Cafe'),
                leading: Radio(
                  value: LocationType.cafe,
                  groupValue: widget.type,
                  onChanged: (LocationType value) {
                    setState(() {
                      widget.type = value;
                      // Provider.of<Store>(context, listen: false)
                      //     .changeTypeFilter(value);
                    });
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Gas Station'),
                leading: Radio(
                  value: LocationType.gas_station,
                  groupValue: widget.type,
                  onChanged: (LocationType value) {
                    setState(() {
                      widget.type = value;
                      // Provider.of<Store>(context, listen: false)
                      //     .changeTypeFilter(value);
                    });
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Grocery'),
                leading: Radio(
                  value: LocationType.grocery,
                  groupValue: widget.type,
                  onChanged: (LocationType value) {
                    setState(() {
                      // Provider.of<Store>(context, listen: false)
                      //     .changeTypeFilter(value);
                      widget.type = value;
                    });
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Hotel'),
                leading: Radio(
                  value: LocationType.hotel,
                  groupValue: widget.type,
                  onChanged: (LocationType value) {
                    setState(() {
                      widget.type = value;
                      // Provider.of<Store>(context, listen: false)
                      //     .changeTypeFilter(value);
                    });
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Music Venue'),
                leading: Radio(
                  value: LocationType.music_venue,
                  groupValue: widget.type,
                  onChanged: (LocationType value) {
                    setState(() {
                      widget.type = value;
                      // Provider.of<Store>(context, listen: false)
                      //     .changeTypeFilter(value);
                    });
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Pharmacy'),
                leading: Radio(
                  value: LocationType.pharmacy,
                  groupValue: widget.type,
                  onChanged: (LocationType value) {
                    setState(() {
                      widget.type = value;
                      // Provider.of<Store>(context, listen: false)
                      //     .changeTypeFilter(value);
                    });
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Post Office'),
                leading: Radio(
                  value: LocationType.post_office,
                  groupValue: widget.type,
                  onChanged: (LocationType value) {
                    setState(() {
                      widget.type = value;
                      // Provider.of<Store>(context, listen: false)
                      //     .changeTypeFilter(value);
                    });
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Restaurant'),
                leading: Radio(
                  value: LocationType.restaurant,
                  groupValue: widget.type,
                  onChanged: (LocationType value) {
                    setState(() {
                      widget.type = value;
                      // Provider.of<Store>(context, listen: false)
                      //     .changeTypeFilter(value);
                    });
                  },
                ),
              ),
              // ListTile(
              //   dense: true,
              //   title: const Text('Retail'),
              //   leading: Radio(
              //     value: LocationType.retail,
              //     groupValue: widget.type,
              //     onChanged: (LocationType value) {
              //       setState(() {
              //         //widget.type = value;
              //         Provider.of<Store>(context, listen: false)
              //             .changeTypeFilter(value);
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                  ? Colors.black
                  : Colors.white,
        ),
        child: BottomNavigationBar(
          //backgroundColor: AppTheme.nearlyWhite,
          selectedFontSize: 12,
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
                "Apply",
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
          ],
        ),
      ),
    );
  }
}

// FormBuilder(
//             key: _fbFilterKey,
//             autovalidate: true,
//             //initialValue: {"type": "Bar"},
//             child: Column(
//               children: <Widget>[
//                 // types
//                 FormBuilderChoiceChip(
//                   attribute: "type",
//                   decoration: InputDecoration(labelText: "Filter by type"),
//                   options: [
//                     FormBuilderFieldOption(
//                       child: Text("Restaurant"),
//                       value: "Restaurant",
//                     ),
//                     FormBuilderFieldOption(
//                       child: Text("Hotel"),
//                       value: "Hotel",
//                     ),
//                     FormBuilderFieldOption(
//                       child: Text("Bar"),
//                       value: "Bar",
//                     ),
//                     FormBuilderFieldOption(
//                       child: Text("Cafe"),
//                       value: "Cafe",
//                     ),
//                     FormBuilderFieldOption(
//                       child: Text("Music Venue"),
//                       value: "Music Venue",
//                     ),
//                     FormBuilderFieldOption(
//                       child: Text("Grocery"),
//                       value: "Grocery",
//                     ),
//                     FormBuilderFieldOption(
//                       child: Text("Gas Station"),
//                       value: "Gas Station",
//                     ),
//                     FormBuilderFieldOption(
//                       child: Text("Bank"),
//                       value: "Bank",
//                     ),
//                     FormBuilderFieldOption(
//                       child: Text("Post Office"),
//                       value: "Post Office",
//                     ),
//                     FormBuilderFieldOption(
//                       child: Text("Pharmacy"),
//                       value: "Pharmacy",
//                     ),
//                     FormBuilderFieldOption(
//                       child: Text("Retail"),
//                       value: "Retail",
//                     ),
//                     FormBuilderFieldOption(
//                       child: Text("Hospital"),
//                       value: "Hospital",
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
