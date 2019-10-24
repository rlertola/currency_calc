import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            title: const Text('Favorites'),
          ),
        ],
      ),
    );
  }
}
