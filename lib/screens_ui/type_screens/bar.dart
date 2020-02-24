import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';

class Bar extends StatefulWidget {
  Bar({this.location});

  final LocationLoadedModel location;

  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  double opacity1 = 0.0;

  double opacity2 = 0.0;

  double opacity3 = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Bar Info'),
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.local_bar),
                    title: Text('Specials'),
                    subtitle: widget.location.description != ""
                        ? Text('${widget.location.description}')
                        : Text('No Specials'),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.loop),
                    title: Text('Wait'),
                    subtitle: widget.location.description != ""
                        ? Text('Currently there is a 30 min wait')
                        : Text('Currently no wait'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
