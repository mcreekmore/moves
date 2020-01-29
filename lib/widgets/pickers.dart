// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

// List list = [];

// DropdownButtonFormField androidDropDown(List list) {
//   List<DropdownMenuItem<String>> dropdownItems = [];

//   for (String item in list) {
//     var newItem = DropdownMenuItem(
//       child: Text(item),
//       value: list,
//     );

//     dropdownItems.add(newItem);
//   }

//   return DropdownButtonFormField(
//     decoration: const InputDecoration(
//       labelText: '*Type',
//       border: OutlineInputBorder(),
//     ),
//     value: selectedType,
//     items: dropdownItems,
//     onChanged: (value) {
//       setState(() {
//         selectedType = value.toString();
//       });
//     },
//   );
//   // return DropdownButton<String>(
//   //   value: selectedType,
//   //   items: dropdownItems,
//   //   onChanged: (value) {
//   //     setState(() {
//   //       selectedType = value.toString();
//   //     });
//   //   },
//   // );
// }

// CupertinoPicker iOSPicker() {
//   List<Text> pickerItems = [];

//   for (String item in list) {
//     pickerItems.add(Text(item));
//   }

//   return CupertinoPicker(
//     backgroundColor: Colors.lightBlue,
//     itemExtent: 32,
//     onSelectedItemChanged: (int selectedIndex) {
//       print(selectedIndex);
//     },
//     children: pickerItems,
//   );
// }
