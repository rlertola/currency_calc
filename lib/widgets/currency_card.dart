import 'package:bread_currency/constants.dart';
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
    List<Widget> quoteResult = [
      Text(
        '$baseAmount $baseSymbol = ',
        style: TextStyle(
          fontFamily: 'Questrial',
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        '$value $countryCode',
        style: TextStyle(
          fontFamily: 'Questrial',
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    ];
    return Container(
      // height: 200,
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
              // color: Colors.grey.shade400,
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 14,
              ),
              Text(
                countryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                ),
              ),
              Text(
                currencyName,
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                image,
                scale: 2.5,
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

              // Text(
              //     '$baseAmount $baseSymbol = $value $countryCode',
              //     style: const TextStyle(
              //       fontFamily: 'Questrial',
              //       color: Colors.white,
              //       fontSize: 28,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),

              //
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
