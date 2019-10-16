import 'package:bread_currency/screens/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:bread_currency/models/currency_data.dart';
import 'package:provider/provider.dart';

const double inputAndButtonHeight = 74;

class HeaderContainer extends StatelessWidget {
  String hintText = 1.toStringAsFixed(2);
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyData>(
      builder: (context, currencyData, child) {
        return Container(
          padding: EdgeInsets.all(16),
          // height: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Currency Calculator',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        // vertical: 25,
                      ),
                      height: inputAndButtonHeight,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),

                        // border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        // color: Colors.white70,
                      ),
                      child: Center(
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          cursorWidth: 2,
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.black54,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.chevron_right),
                            contentPadding: EdgeInsets.all(2),
                            hintText:
                                currencyData.baseAmount.toStringAsFixed(2),
                            hintStyle: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          // onChanged: (newAmount) {

                          //   hintText = newAmount.toString();
                          // },
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
                    height: inputAndButtonHeight,
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black87),
                        ),
                    child: RaisedButton(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(
                        //   color: Colors.black54,
                        //   width: 1,
                        // ),
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
                          color: Colors.white,
                          // color: Colors.black54,
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
