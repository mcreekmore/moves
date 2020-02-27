import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RestaurantBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Restaurant Info',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        FormBuilderDropdown(
          attribute: "occupancy",
          decoration: InputDecoration(labelText: "Occupancy"),
          hint: Text('Select Occupancy'),
          items: ['Basically Empty', 'Chill', 'Comfortable', 'Poppin']
              .map(
                (occupancy) => DropdownMenuItem(
                  value: occupancy,
                  child: Text("$occupancy"),
                ),
              )
              .toList(),
        ),
        FormBuilderTextField(
          attribute: "wait",
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "How long is the wait/line? (minutes)"),
          validators: [
            FormBuilderValidators.numeric(),
          ],
        ),
        FormBuilderTextField(
          attribute: "specials",
          decoration: InputDecoration(labelText: "Specials / Discounts"),
          validators: [
            FormBuilderValidators.maxLength(300),
          ],
        ),
        FormBuilderFilterChip(
          decoration: InputDecoration(labelText: "Restaurant Styles"),
          attribute: "restaurant_styles",
          options: [
            FormBuilderFieldOption(
              child: Text("College Bar"),
              value: "college_bar",
            ),
            FormBuilderFieldOption(
              child: Text("Sports Bar"),
              value: "sports_bar",
            ),
          ],
        ),
      ],
    );
  }
}
