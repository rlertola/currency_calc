import 'package:bread_currency/screens/base_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:bread_currency/models/currency_data.dart';
import 'package:provider/provider.dart';

class HeaderContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String baseValue = Provider.of<CurrencyData>(context).base;
    double baseAmount = 1;

    return Container(
      height: 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 50,
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '1',
                border: OutlineInputBorder(),
              ),
              onChanged: (newAmount) {
                if (newAmount.isEmpty) {
                  baseAmount = 1;
                } else {
                  baseAmount = double.parse(newAmount);
                }
                Provider.of<CurrencyData>(context)
                    .setBaseAmount(baseAmount, baseValue);
                print(newAmount);
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => BaseMenuScreen(),
              );
            },
            child: Text(baseValue),
          ),
        ],
      ),
    );
  }
}
