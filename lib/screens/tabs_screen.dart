import 'package:bread_currency/models/currency_data.dart';
import 'package:bread_currency/screens/favorites_screen.dart';
import 'package:bread_currency/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sphere_bottom_navigation_bar/sphere_bottom_navigation_bar.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': HomeScreen(),
        'title': 'Currency Converter',
      },
      {
        'page': FavoritesScreen(),
        'title': 'Favorites',
      }
    ];
  }

  _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    Provider.of<CurrencyData>(context).setPageIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightBlue.shade100,
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Colors.lightBlue,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive),
            title: Text('All'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }
}

// SphereBottomNavigationBar(
//         defaultSelectedItem: _selectedPageIndex,
//         sheetRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         onItemPressed: (index) => _selectPage(index),
//         navigationItems: [
//           BuildNavigationItem(
//             tooltip: 'All',
//             icon: Icon(Icons.all_inclusive),
//             itemColor: Colors.blue,
//             selectedItemColor: Colors.blue,
//           ),
//           BuildNavigationItem(
//             tooltip: 'Favorites',
//             icon: Icon(Icons.star),
//             itemColor: Colors.blue,
//             selectedItemColor: Colors.blue,
//           ),
//         ],
//       ),
