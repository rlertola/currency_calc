import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/currency_data.dart';

class CurrencyCard extends StatelessWidget {
  final String countryCode;
  final String baseSymbol;
  final String baseAmount;
  final String countryName;
  final String currencyName;
  final String quoteFlag;
  final String baseFlag;
  final String value;
  final int index;

  CurrencyCard({
    this.countryCode,
    this.baseSymbol,
    this.baseAmount,
    this.countryName,
    this.currencyName,
    this.quoteFlag,
    this.baseFlag,
    this.value,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> quoteResult = [
      Text(
        '$baseAmount $baseSymbol = ',
        style: TextStyle(
          color: Theme.of(context).primaryColorLight,
          fontSize: 18,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        '$value $countryCode',
        style: TextStyle(
          color: Theme.of(context).primaryColorLight,
          fontSize: 30,
        ),
      ),
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: GestureDetector(
        onLongPress: () {
          CurrencyData currencyData = Provider.of<CurrencyData>(context);
          currencyData.toggleFavorite(index);
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: currencyData.pageIndex == 0
                  ? const Text(kItemAddedToFavorites)
                  : const Text(kItemRemovedFromFavorites),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Card(
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 0.3,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 14,
              ),
              Text(
                countryName,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  // color: Theme.of(context).accentColor,
                  fontSize: 38,
                ),
              ),
              Text(
                currencyName,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    baseFlag,
                    scale: 2.5,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    'assets/right_arrow3.png',
                    scale: 30,
                    // width: 30,
                    // height: 18,
                    color: Theme.of(context).hintColor,
                    // color: Theme.of(context).primaryColorLight,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    quoteFlag,
                    scale: 2.5,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              (baseAmount.length > 5)
                  ? Column(
                      children: quoteResult,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: quoteResult,
                    ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
