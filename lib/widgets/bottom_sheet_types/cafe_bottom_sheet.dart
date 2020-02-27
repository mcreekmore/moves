import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CafeBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Cafe Info',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Occupancy"),
          attribute: "location_occupancy_chip",
          options: [
            FormBuilderFieldOption(child: Text("Empty"), value: "empty"),
            FormBuilderFieldOption(child: Text("Low"), value: "low"),
            FormBuilderFieldOption(child: Text("Medium"), value: "medium"),
            FormBuilderFieldOption(child: Text("High"), value: "high"),
            FormBuilderFieldOption(child: Text("Max"), value: "max"),
          ],
        ),
      ],
    );
  }
}
