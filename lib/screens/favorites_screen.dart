import 'package:bread_currency/constants.dart';
import 'package:bread_currency/models/currency_data.dart';
import 'package:bread_currency/screens/no_favorites_screen.dart';
import 'package:bread_currency/widgets/currency_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  Future<void> _refreshFavorites(BuildContext context) async {
    await Provider.of<CurrencyData>(context, listen: false).updateFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder(
          future: _refreshFavorites(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                return Center(
                  child: Text(kErrorMessage),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () => _refreshFavorites(context),
                  child: Consumer<CurrencyData>(
                    builder: (context, currencyData, child) {
                      return (currencyData.favCount == 0)
                          ? Center(
                              child: NoFavoritesScreen(),
                            )
                          : ListView.builder(
                              itemCount: currencyData.favCount,
                              itemBuilder: ((context, i) {
                                final fav = currencyData.favorites[i];
                                return CurrencyCard(
                                  countryCode: fav.countrySymbol,
                                  baseSymbol: fav.baseSymbol,
                                  baseAmount: fav.baseAmount,
                                  countryName: fav.countryName,
                                  currencyName: fav.currencyName,
                                  image: fav.imageUrl,
                                  value: fav.quotePrice,
                                  index: i,
                                );
                              }),
                            );
                    },
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
