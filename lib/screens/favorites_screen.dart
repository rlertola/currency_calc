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
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 12,
          left: 12,
          right: 12,
        ),
        // color: Theme.of(context).accentColor,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: FutureBuilder(
          future: _refreshFavorites(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
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
