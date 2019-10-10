import 'package:bread_currency/screens/base_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:bread_currency/models/currency_data.dart';
import 'package:provider/provider.dart';

const double inputAndButtonHeight = 74;

class HeaderContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyData>(
      builder: (context, currencyData, child) {
        return Container(
          padding: EdgeInsets.only(
            top: 30,
            left: 16,
            right: 16,
            bottom: 18,
          ),
          // height: 100,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(20),
            //   bottomRight: Radius.circular(20),
            // ),
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
                        color: Colors.white70,
                      ),
                      child: Center(
                        child: TextField(
                          // cursorColor: Colors.black54,
                          cursorWidth: 2,
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.black54,
                          ),

                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.arrow_right),
                            prefixIcon: Icon(Icons.chevron_right),
                            // prefixIcon: Image.network(
                            //   'https://doesmoneymotivate.files.wordpress.com/2015/09/currency-sign-universal.png?w=100',
                            //   scale: 4,
                            // ),
                            // prefixIcon: Icon(Icons.arrow_forward_ios),
                            contentPadding: EdgeInsets.all(2),

                            hintText:
                                currencyData.baseAmount.toStringAsFixed(2),
                            hintStyle: TextStyle(
                              fontSize: 30,
                              color: Colors.black26,
                            ),
                            // focusedBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.black54,
                            //     style: BorderStyle.solid,
                            //   ),
                            // ),
                            // enabledBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.black38,
                            //     width: 2.0,
                            //     style: BorderStyle.solid,
                            //   ),
                            // ),
                          ),
                          onChanged: (newAmount) {
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
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      color: Colors.lightBlue.shade200,
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
