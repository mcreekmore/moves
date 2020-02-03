import 'package:flutter/material.dart';
import 'package:moves/screens/home_screen.dart';
import 'package:moves/screens/map_screen.dart';
import 'package:moves/screens/sign_in.dart';

class NavScreen extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static List<Widget> _widgetOptions = <Widget>[
  //   HomeScreen(),
  //   MapScreen(),
  //   ProfileScreen(),
  // ];

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Moves")),
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: <Widget>[
            HomeScreen(),
            MapScreen(),
            SignInScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Text('Item One'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            title: Text('Item One'),
            icon: Icon(Icons.map),
          ),
          BottomNavigationBarItem(
            title: Text('Item One'),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOutExpo);
    });
  }
}

// class _NavScreenState extends State<NavScreen> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DrawerWidget(),
//       appBar: AppBar(
//         title: const Text('Moves'),
//       ),
//       body: NavScreen._widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             backgroundColor: Colors.red,
//             icon: Icon(Icons.home),
//             title: Text(
//               'Home',
//               style: TextStyle(fontSize: 10),
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.map),
//             title: Text(
//               'Map',
//               style: TextStyle(fontSize: 10),
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             title: Text(
//               'Profile',
//               style: TextStyle(fontSize: 10),
//             ),
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.green,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
