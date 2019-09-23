import 'package:bread_currency/models/currency_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyCard extends StatelessWidget {
  final countryCode;
  final baseSymbol;
  final baseAmount;
  final countryName;
  final currencyName;
  final image;
  final value;
  final index;

  CurrencyCard({
    this.countryCode,
    this.baseSymbol,
    this.baseAmount,
    this.countryName,
    this.currencyName,
    this.image,
    this.value,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      // padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(5),
      // color: Colors.white30,
      child: GestureDetector(
        onLongPress: () {
          Provider.of<CurrencyData>(context).addToFavorites(index);
          print(index);
        },
        child: Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                countryName,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              Text(
                currencyName,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image.network(
                image,
                scale: 12,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$baseAmount $baseSymbol',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    ' = ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '$value $countryCode',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
