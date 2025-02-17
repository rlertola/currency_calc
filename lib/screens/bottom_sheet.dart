import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/currency_data.dart';

class BaseMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 4,
          ),
          Text(
            'Choose Base Currency',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: Provider.of<CurrencyData>(context).quoteCount,
              itemBuilder: (context, i) {
                final menuItem =
                    Provider.of<CurrencyData>(context).menuItems[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: Image.asset(
                      Provider.of<CurrencyData>(context).quotes[i].quoteFlag,
                      scale: 2.5,
                    ),
                    title: Text(
                      menuItem.countryName,
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade700),
                    ),
                    trailing: Text(
                      menuItem.currencySymbol,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    onTap: () {
                      Provider.of<CurrencyData>(context).getCurrencyData(
                        baseSymbol: menuItem.currencySymbol,
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
