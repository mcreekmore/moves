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
          decoration: InputDecoration(labelText: "Tea available?"),
          attribute: "cafe_tea_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Coffee available?"),
          attribute: "cafe_coffee_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration:
              InputDecoration(labelText: "Uncaffeinated bevrage options?"),
          attribute: "cafe_uncaffeinated_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Are there breakfast foods?"),
          attribute: "cafe_breakfast_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Are there lunch options?"),
          attribute: "cafe_lunch_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Inside seating available?"),
          attribute: "cafe_inside_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Outside seating available?"),
          attribute: "cafe_outside_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration:
              InputDecoration(labelText: "Is there a drive through-available?"),
          attribute: "cafe_drive_through_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration:
              InputDecoration(labelText: "Is online ordering supported?"),
          attribute: "cafe_online_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
      ],
    );
  }
}
