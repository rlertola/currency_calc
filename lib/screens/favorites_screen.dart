import 'package:bread_currency/models/currency_data.dart';
import 'package:bread_currency/widgets/currency_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final favCount = Provider.of<CurrencyData>(context).favCount;
    return Consumer<CurrencyData>(
      builder: (context, currencyData, child) {
        return Scaffold(
          body: (currencyData.favCount == 0)
              ? Center(
                  child:
                      Text('Long-press on a card to add it to your favorites!'),
                )
              : ListView.builder(
                  itemCount: currencyData.favCount,
                  itemBuilder: (context, i) {
                    final fav = currencyData.favorites[i];
                    return CurrencyCard(
                      countryCode: fav.countrySymbol,
                      baseSymbol: fav.baseSymbol,
                      baseAmount: fav.baseAmount,
                      countryName: fav.countryName,
                      currencyName: fav.currencyName,
                      image: fav.imageUrl,
                      value: fav.quotePrice,
                    );
                  },
                ),
        );
      },
    );
  }
}
