import 'package:flutter/material.dart';
import 'package:moves/app_theme.dart';
import 'package:flutter/cupertino.dart';

class Picker extends StatefulWidget {
  Picker({this.displayList});

  final List displayList;

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  String selectedType = '';

  DropdownButtonFormField androidDropDown(int index) {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String listItem in widget.displayList) {
      var newItem = DropdownMenuItem(
        child: Text(listItem),
        value: listItem,
      );

      dropdownItems.add(newItem);
    }

    return DropdownButtonFormField(
      // decoration: const InputDecoration(
      //   labelText: '*Type',
      //   border: OutlineInputBorder(),
      // ),
      decoration: AppTheme().getInputDecorationTheme(
          labelText: "*Type", fillColor: Color(0xFFb5cdfc)),
      value: selectedType,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedType = value.toString();
        });
      },
    );
    // return DropdownButton<String>(
    //   value: selectedType,
    //   items: dropdownItems,
    //   onChanged: (value) {
    //     setState(() {
    //       selectedType = value.toString();
    //     });
    //   },
    // );
  }

  CupertinoPicker iOSPicker(int index) {
    List<Text> pickerItems = [];

    for (String listItem in widget.displayList) {
      pickerItems.add(Text(listItem));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (int selectedIndex) {
        //print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
