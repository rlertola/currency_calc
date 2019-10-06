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
          decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 25,
                  ),
                  // height: 100,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey),
                    color: Colors.white70,
                  ),
                  child: Center(
                    child: TextField(
                      cursorWidth: 4,
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.black54,
                      ),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.label),
                        // prefixIcon: Icon(Icons.label_outline),
                        // prefixIcon: Icon(Icons.arrow_right),
                        // prefixIcon: Icon(Icons.chevron_right),

                        prefixIcon: Image.network(
                          'https://doesmoneymotivate.files.wordpress.com/2015/09/currency-sign-universal.png?w=100',
                          scale: 4,
                        ),

                        // prefixIcon: Icon(Icons.arrow_forward_ios),

                        contentPadding: EdgeInsets.all(4),
                        hintText: currencyData.baseAmount.toStringAsFixed(0),
                        hintStyle: TextStyle(
                          fontSize: 36,
                          color: Colors.black38,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black54,
                            style: BorderStyle.solid,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 2.0,
                            style: BorderStyle.solid,
                          ),
                        ),
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
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black87),
                      ),
                  child: RaisedButton(
                    color: Colors.green,
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
                        fontSize: 36,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Container(
//           height: 100,
//           width: double.infinity,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 width: 100,
//                 height: 50,
//                 child: TextField(
//                   keyboardType: TextInputType.number,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     hintText: currencyData.baseAmount.toString(),
//                     border: OutlineInputBorder(),
//                   ),
//                   onChanged: (newAmount) {
//                     if (newAmount.isEmpty) {
//                       currencyData.baseAmount = 1;
//                     } else {
//                       currencyData.baseAmount = double.parse(newAmount);
//                     }
//                     currencyData.setBaseAmount(
//                         currencyData.baseAmount, currencyData.base);
//                     print(newAmount);
//                   },
//                 ),
//               ),
//               RaisedButton(
//                 onPressed: () {
//                   showModalBottomSheet(
//                     context: context,
//                     builder: (context) => BaseMenuScreen(),
//                   );
//                 },
//                 child: Text(currencyData.base),
//               ),
//             ],
//           ),
//         );
