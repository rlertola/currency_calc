import 'package:bread_currency/models/currency_data.dart';
import 'package:bread_currency/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
          textTheme: TextTheme(),
          bottomAppBarColor: Colors.grey.shade300,
          buttonColor: Colors.blue.shade200,
          dividerColor: Theme.of(context).primaryColor,
          fontFamily: 'Questrial',
        ),

        // home: HomeScreen(),
        home: TabsScreen(),
      ),
    );
  }
}
