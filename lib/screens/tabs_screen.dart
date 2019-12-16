import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sphere_bottom_navigation_bar/sphere_bottom_navigation_bar.dart';

import '../providers/currency_data.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';

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
        'title': 'Home',
      },
      {
        'page': FavoritesScreen(),
        'title': 'Favorites',
      }
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    Provider.of<CurrencyData>(context).setPageIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: SphereBottomNavigationBar(
        defaultSelectedItem: _selectedPageIndex,
        sheetRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        onItemPressed: _selectPage,
        navigationItems: [
          BuildNavigationItem(
            tooltip: 'Home',
            itemColor: Theme.of(context).hintColor,
            icon: Icon(Icons.home),
            selectedItemColor: Theme.of(context).buttonColor,
          ),
          BuildNavigationItem(
            tooltip: 'Favorites',
            itemColor: Theme.of(context).hintColor,
            icon: Icon(Icons.star),
            selectedItemColor: Theme.of(context).buttonColor,
          ),
        ],
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _selectPage,
      //   currentIndex: _selectedPageIndex,
      //   backgroundColor: Theme.of(context).bottomAppBarColor,
      //   selectedItemColor: Theme.of(context).buttonColor,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.home),
      //       title: const Text('Home'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.star),
      //       title: const Text('Favorites'),
      //     ),
      //   ],
      // ),
    );
  }
}
