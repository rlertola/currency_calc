import 'package:bread_currency/screens/base_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:bread_currency/models/currency_data.dart';
import 'package:provider/provider.dart';

class HeaderContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyData>(
      builder: (context, currencyData, child) {
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
                    hintText: currencyData.baseAmount.toString(),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (newAmount) {
                    if (newAmount.isEmpty) {
                      currencyData.baseAmount = 1;
                    } else {
                      currencyData.baseAmount = double.parse(newAmount);
                    }
                    currencyData.setBaseAmount(
                        currencyData.baseAmount, currencyData.base);
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
                child: Text(currencyData.base),
              ),
            ],
          ),
        );
      },
    );
  }
}
