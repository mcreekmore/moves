import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: FloatingSearchBar.builder(
          itemCount: 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text(index.toString()),
            );
          },
          trailing: CircleAvatar(
            child: Text(
              "Moves",
              style: TextStyle(fontSize: 8),
            ),
          ),
          onChanged: (String value) {},
          onTap: () {},
          decoration: InputDecoration.collapsed(
            hintText: "Search...",
          ),
        ),
      ),
    );
  }
}
