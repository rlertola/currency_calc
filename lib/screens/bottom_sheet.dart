import 'package:bread_currency/models/currency_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      menuItem.currencySymbol,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
        ],
      ),
    );
  }
}
