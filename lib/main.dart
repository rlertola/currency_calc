import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/currency_data.dart';
import 'screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrencyData>(
      builder: (context) => CurrencyData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blue.shade600,
          accentColor: Colors.white,
          canvasColor: Colors.transparent,
          hintColor: Colors.black26,
          bottomAppBarColor: Colors.grey.shade300,
          buttonColor: Colors.blue.shade200,
          dividerColor: Theme.of(context).primaryColor,
          fontFamily: 'Questrial',
        ),
        home: TabsScreen(),
      ),
    );
  }
}
