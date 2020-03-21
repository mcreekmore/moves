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
              labelText: "How long is the wait/line? (minutes)"),
          validators: [
            FormBuilderValidators.numeric(),
          ],
        ),
        // FormBuilderTextField(
        //   attribute: "restaurant_specials",
        //   decoration: InputDecoration(labelText: "Specials / Discounts"),
        //   validators: [
        //     FormBuilderValidators.maxLength(300),
        //   ],
        // ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Inside seating?"),
          attribute: "restaurant_inside_seating_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Outside seating?"),
          attribute: "restaurant_outside_seating_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Take-out available?"),
          attribute: "restaurant_take_out_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Curb-side pickup available?"),
          attribute: "restaurant_curb_side_bool",
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        // FormBuilderFilterChip(
        //   decoration: InputDecoration(labelText: "Restaurant Styles"),
        //   attribute: "restaurant_styles",
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
