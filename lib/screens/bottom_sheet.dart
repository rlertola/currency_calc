import 'package:bread_currency/models/currency_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
      child: BottomSheet(
        onClosing: () {},
        builder: (context) => AnimatedContainer(
          duration: Duration(seconds: 2),
          curve: Curves.linear,
          child: ListView.builder(
            itemCount: Provider.of<CurrencyData>(context).quoteCount,
            itemBuilder: (context, i) {
              final menuItem = Provider.of<CurrencyData>(context).menuItems[i];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(menuItem.currencySymbol),
                ),
                title: Text(menuItem.countryName),
                onTap: () {
                  Provider.of<CurrencyData>(context).getCurrencyData(
                    baseSymbol: menuItem.currencySymbol,
                  );
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

// Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Choose Base Currency',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: Provider.of<CurrencyData>(context).quoteCount,
//         itemBuilder: (context, i) {
//           final menuItem = Provider.of<CurrencyData>(context).menuItems[i];
//           return ListTile(
//             leading: CircleAvatar(
//               child: Text(menuItem.currencySymbol),
//             ),
//             title: Text(menuItem.countryName),
//             onTap: () {
//               Provider.of<CurrencyData>(context).getCurrencyData(
//                 baseSymbol: menuItem.currencySymbol,
//               );
//               Navigator.of(context).pop();
//             },
//           );
//         },
//       ),
//     );
