import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HotelBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Hotel Info',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Are there vacancies?"),
          attribute: "hotel_vacancies_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Is there free WIFI?"),
          attribute: "hotel_wifi_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration:
              InputDecoration(labelText: "Do they offer free breakfast?"),
          attribute: "hotel_breakfast_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Is there a pool?"),
          attribute: "hotel_pool_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Is there air conditioning?"),
          attribute: "hotel_air_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Is there a bar?"),
          attribute: "hotel_bar_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Are pets accepted?"),
          attribute: "hotel_pets_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Is there a wellness center?"),
          attribute: "hotel_wellness_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
      ],
    );
  }
}
