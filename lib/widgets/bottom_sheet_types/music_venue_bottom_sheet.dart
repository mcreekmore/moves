import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MusicVenueBottomSheet extends StatefulWidget {
  @override
  _MusicVenueBottomSheetState createState() => _MusicVenueBottomSheetState();
}

class _MusicVenueBottomSheetState extends State<MusicVenueBottomSheet> {
  bool addPerformanceBool = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Music Venue Info',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        FormBuilderSwitch(
          label: Text('Add a performance?'),
          attribute: "music_performance_bool",
          initialValue: addPerformanceBool,
          onChanged: (val) {
            setState(() {
              addPerformanceBool = !addPerformanceBool;
            });
          },
        ),
        Visibility(
          visible: addPerformanceBool,
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                attribute: "music_performer_name",
                decoration: InputDecoration(
                  labelText: "Name of performer(s)",
                  labelStyle: TextStyle(color: Colors.grey[600]),
                ),
                validators: [
                  FormBuilderValidators.max(70),
                ],
              ),
              FormBuilderDateTimePicker(
                attribute: "music_performance_date",
                inputType: InputType.date,
                decoration: InputDecoration(
                  labelText: "Performance Day",
                ),
                initialValue: DateTime.now(),
                valueTransformer: (val) {
                  return val.toIso8601String();
                },
              ),
            ],
          ),
        ),
        Visibility(
          visible: !addPerformanceBool,
          child: Column(
            children: <Widget>[
              FormBuilderChoiceChip(
                decoration: InputDecoration(labelText: "18+ only?"),
                attribute: "music_18_bool",
                selectedColor: Colors.blueAccent,
                options: [
                  FormBuilderFieldOption(child: Text("Yes"), value: "true"),
                  FormBuilderFieldOption(child: Text("No"), value: "false"),
                ],
              ),
              FormBuilderChoiceChip(
                decoration: InputDecoration(labelText: "21+ only?"),
                attribute: "music_21_bool",
                selectedColor: Colors.blueAccent,
                options: [
                  FormBuilderFieldOption(child: Text("Yes"), value: "true"),
                  FormBuilderFieldOption(child: Text("No"), value: "false"),
                ],
              ),
              FormBuilderChoiceChip(
                decoration:
                    InputDecoration(labelText: "Do they serve alcohol?"),
                attribute: "music_alcohol_bool",
                selectedColor: Colors.blueAccent,
                options: [
                  FormBuilderFieldOption(child: Text("Yes"), value: "true"),
                  FormBuilderFieldOption(child: Text("No"), value: "false"),
                ],
              ),
              FormBuilderChoiceChip(
                decoration: InputDecoration(labelText: "Is there an ATM?"),
                attribute: "music_atm_bool",
                selectedColor: Colors.blueAccent,
                options: [
                  FormBuilderFieldOption(child: Text("Yes"), value: "true"),
                  FormBuilderFieldOption(child: Text("No"), value: "false"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
