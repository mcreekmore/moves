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
        FormBuilderTextField(
          attribute: "restaurant_wait",
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "How long is the wait/line? (minutes)",
            labelStyle: TextStyle(color: Colors.grey[600]),
          ),
          validators: [
            FormBuilderValidators.numeric(),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Inside seating?"),
          attribute: "restaurant_inside_seating_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Outside seating?"),
          attribute: "restaurant_outside_seating_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Take-out available?"),
          attribute: "restaurant_take_out_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Curb-side pickup available?"),
          attribute: "restaurant_curb_side_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        // FormBuilderFilterChip(
        //   decoration: InputDecoration(labelText: "Restaurant Styles"),
        //   attribute: "restaurant_styles",
        //   selectedColor: Colors.blueAccent,
        //   options: [
        //     FormBuilderFieldOption(
        //       child: Text("College Bar"),
        //       value: "college_bar",
        //     ),
        //     FormBuilderFieldOption(
        //       child: Text("Sports Bar"),
        //       value: "sports_bar",
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
