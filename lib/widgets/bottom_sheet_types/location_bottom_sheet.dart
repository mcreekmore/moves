import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LocationBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Location Info',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Is this location open?"),
          attribute: "location_open_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderSegmentedControl(
          decoration: InputDecoration(labelText: "Location Rating"),
          attribute: "location_rating",
          selectedColor: Colors.blueAccent,
          options: List.generate(5, (i) => i + 1)
              .map(
                (number) => FormBuilderFieldOption(value: number),
              )
              .toList(),
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Occupancy"),
          attribute: "location_occupancy",
          selectedColor: Colors.blueAccent,
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
