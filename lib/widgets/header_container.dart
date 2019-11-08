import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/currency_data.dart';
import '../screens/bottom_sheet.dart';
import 'package:bread_currency/constants.dart';

const double _inputAndButtonHeight = 74;

class HeaderContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyData>(
      builder: (context, currencyData, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                kAppLabel,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      height: _inputAndButtonHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: Theme.of(context).accentColor,
                      ),
                      child: Center(
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          cursorWidth: 2,
                          style: const TextStyle(
                            fontSize: 36,
                            color: Colors.black54,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.chevron_right),
                            contentPadding: const EdgeInsets.all(2),
                            hintText:
                                currencyData.baseAmount.toStringAsFixed(2),
                            hintStyle: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          onSubmitted: (newAmount) {
                            if (newAmount.isEmpty) {
                              currencyData.baseAmount = 1;
                            } else {
                              currencyData.baseAmount = double.parse(newAmount);
                            }
                            currencyData.setBaseAmount(
                                currencyData.baseAmount, currencyData.base);
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 130,
                    height: _inputAndButtonHeight,
                    child: RaisedButton(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => BaseMenuScreen(),
                        );
                      },
                      child: Text(
                        currencyData.base,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
