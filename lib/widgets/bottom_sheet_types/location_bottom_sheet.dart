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
        FormBuilderSegmentedControl(
          decoration: InputDecoration(labelText: "Location Rating"),
          attribute: "location_rating",
          options: List.generate(5, (i) => i + 1)
              .map(
                (number) => FormBuilderFieldOption(value: number),
              )
              .toList(),
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Occupancy"),
          attribute: "location_occupancy",
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
