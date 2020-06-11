import 'package:flutter/material.dart';
import 'package:moves/model/chip_selected.dart';
import 'package:moves/store/store.dart';
import 'package:provider/provider.dart';

class FilterBar extends StatefulWidget {
  FilterBar({this.favoriteSelected, this.callback});

  final bool favoriteSelected;
  final Function callback;

  @override
  _FilterBarState createState() => _FilterBarState();
}

ChipSelected selectedEnumValue;

class _FilterBarState extends State<FilterBar> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(width: 8),
          InputChip(
            avatar: Icon(Icons.local_drink),
            label: Text('Water'),
            labelPadding: EdgeInsets.all(2),
            onSelected: (bool boool) {
              if (selectedEnumValue == ChipSelected.grocery_water_percent_day) {
                selectedEnumValue = null;
                widget.callback(null);
              } else {
                setState(() {
                  selectedEnumValue = ChipSelected.grocery_water_percent_day;
                  widget.callback(selectedEnumValue);
                });
              }
            },
            selectedColor: Colors.blueAccent,
            selected:
                selectedEnumValue == ChipSelected.grocery_water_percent_day
                    ? true
                    : false,
            showCheckmark: false,
          ),
          SizedBox(width: 3),
          InputChip(
            avatar: Icon(Icons.wc),
            label: Text('Toilet Paper'),
            labelPadding: EdgeInsets.all(2),
            onSelected: (bool boool) {
              if (selectedEnumValue ==
                  ChipSelected.grocery_toilet_paper_percent_day) {
                selectedEnumValue = null;
                widget.callback(null);
              } else {
                setState(() {
                  selectedEnumValue =
                      ChipSelected.grocery_toilet_paper_percent_day;
                  widget.callback(selectedEnumValue);
                });
              }
            },
            selectedColor: Colors.blueAccent,
            selected: selectedEnumValue ==
                    ChipSelected.grocery_toilet_paper_percent_day
                ? true
                : false,
            showCheckmark: false,
          ),
          SizedBox(width: 3),
          InputChip(
            avatar: Icon(Icons.bubble_chart),
            label: Text('Disenfectants'),
            labelPadding: EdgeInsets.all(2),
            onSelected: (bool boool) {
              if (selectedEnumValue ==
                  ChipSelected.grocery_disinfectants_percent_day) {
                selectedEnumValue = null;
                widget.callback(null);
              } else {
                setState(() {
                  selectedEnumValue =
                      ChipSelected.grocery_disinfectants_percent_day;
                  widget.callback(selectedEnumValue);
                });
              }
            },
            selectedColor: Colors.blueAccent,
            selected: selectedEnumValue ==
                    ChipSelected.grocery_disinfectants_percent_day
                ? true
                : false,
            showCheckmark: false,
          ),
          SizedBox(width: 3),
          InputChip(
            avatar: Icon(Icons.pregnant_woman),
            label: Text('Feminine Hygiene'),
            labelPadding: EdgeInsets.all(2),
            onSelected: (bool boool) {
              if (selectedEnumValue ==
                  ChipSelected.grocery_feminine_percent_day) {
                selectedEnumValue = null;
                widget.callback(null);
              } else {
                setState(() {
                  selectedEnumValue = ChipSelected.grocery_feminine_percent_day;
                  widget.callback(selectedEnumValue);
                });
              }
            },
            selectedColor: Colors.blueAccent,
            selected:
                selectedEnumValue == ChipSelected.grocery_feminine_percent_day
                    ? true
                    : false,
            showCheckmark: false,
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
