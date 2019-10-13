import 'package:bread_currency/models/currency_data.dart';
import 'package:bread_currency/screens/favorites_screen.dart';
import 'package:bread_currency/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.all_inclusive),
            title: const Text('All'),
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
