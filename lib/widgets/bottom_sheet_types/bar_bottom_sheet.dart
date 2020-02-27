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
              labelText: "How long is the wait/line? (minutes)"),
          validators: [
            FormBuilderValidators.numeric(),
          ],
        ),
        FormBuilderCheckbox(
          attribute: 'bar_cover_bool',
          label: Text(
            "Is there a cover?",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        FormBuilderTextField(
          attribute: "bar_cover_charge",
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "If yes, what is the cover? (dollars)"),
          validators: [
            FormBuilderValidators.numeric(),
          ],
        ),
        FormBuilderTextField(
          attribute: "bar_specials",
          decoration: InputDecoration(labelText: "Specials / Discounts"),
          validators: [
            FormBuilderValidators.maxLength(300),
          ],
        ),
        FormBuilderFilterChip(
          decoration: InputDecoration(labelText: "Bar Styles"),
          attribute: "bar_styles",
          options: [
            FormBuilderFieldOption(
              child: Text("College Bar"),
              value: "college_bar",
            ),
            FormBuilderFieldOption(
              child: Text("Sports Bar"),
              value: "sports_bar",
            ),
            FormBuilderFieldOption(
              child: Text("Dive Bar"),
              value: "dive_bar",
            ),
            FormBuilderFieldOption(
              child: Text("Cigar Bar"),
              value: "cigar_bar",
            ),
            FormBuilderFieldOption(
              child: Text("Wine Bar"),
              value: "wine_bar",
            ),
            FormBuilderFieldOption(
              child: Text("Cocktail Bar"),
              value: "cocktail_bar",
            ),
            FormBuilderFieldOption(
              child: Text("Irish Pub"),
              value: "irish_pub",
            ),
          ],
        ),
      ],
    );
  }
}
