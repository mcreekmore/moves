import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PostOfficeBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Post Office Info',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "Accepting parcels inside?"),
          attribute: "post_parcel_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration:
              InputDecoration(labelText: "Outside parcel drop-off available?"),
          attribute: "post_outside_bool",
          selectedColor: Colors.blueAccent,
          options: [
            FormBuilderFieldOption(child: Text("Yes"), value: "true"),
            FormBuilderFieldOption(child: Text("No"), value: "false"),
          ],
        ),
        FormBuilderChoiceChip(
          decoration: InputDecoration(labelText: "PO boxes available?"),
          attribute: "post_po_bool",
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
