import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BarBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Bar Info',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        FormBuilderTextField(
          attribute: "bar_wait",
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
          decoration: InputDecoration(labelText: "Is there a cover?"),
          attribute: "bar_cover_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderTextField(
          attribute: "bar_cover_charge",
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "If yes, what is the cover? (dollars)",
            labelStyle: TextStyle(color: Colors.grey[600]),
          ),
          validators: [
            FormBuilderValidators.numeric(),
          ],
        ),
        // FormBuilderTextField(
        //   attribute: "bar_specials",
        //   decoration: InputDecoration(labelText: "Specials / Discounts"),
        //   validators: [
        //     FormBuilderValidators.maxLength(300),
        //   ],
        // ),
        FormBuilderFilterChip(
          decoration: InputDecoration(labelText: "Bar Styles"),
          attribute: "bar_styles",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(
              child: Text("College Bar"),
              value: "College Bar",
            ),
            FormBuilderFieldOption(
              child: Text("Sports Bar"),
              value: "Sports Bar",
            ),
            FormBuilderFieldOption(
              child: Text("Dive Bar"),
              value: "Dive Bar",
            ),
            FormBuilderFieldOption(
              child: Text("Cigar Bar"),
              value: "Cigar Bar",
            ),
            FormBuilderFieldOption(
              child: Text("Wine Bar"),
              value: "Wine Bar",
            ),
            FormBuilderFieldOption(
              child: Text("Cocktail Bar"),
              value: "Cocktail Bar",
            ),
            FormBuilderFieldOption(
              child: Text("Irish Pub"),
              value: "Irish Pub",
            ),
          ],
        ),
      ],
    );
  }
}
