import 'package:bread_currency/models/currency_data.dart';
import 'package:bread_currency/widgets/currency_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  Future<void> _refreshFavorites(BuildContext context) async {
    print('refresh favs called in favsscreen');
    await Provider.of<CurrencyData>(context, listen: false).updateFavorites();
  }

  @override
  Widget build(BuildContext context) {
    print('building favs list');
    return Scaffold(
      body: FutureBuilder(
        future: _refreshFavorites(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('There was an error retrieving data'),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () => _refreshFavorites(context),
                child: Consumer<CurrencyData>(
                    builder: (context, currencyData, child) {
                  return (currencyData.favCount == 0)
                      ? Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'You have no favorites. Long-press on a card in the All screen to add it to your favorites. Do the same here to remove it!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
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
                }),
              );
            }
          }
        },
      ),
    );
  }
}

// return Consumer<CurrencyData>(
//       builder: (context, currencyData, child) {
//         return Scaffold(
//           body: (currencyData.favCount == 0)
//               ? Center(
//                   child:
//                       Text('Long-press on a card to add it to your favorites!'),
//                 )
//               : ListView.builder(
//                   itemCount: currencyData.favCount,
//                   itemBuilder: (context, i) {
//                     final fav = currencyData.favorites[i];
//                     return CurrencyCard(
//                       countryCode: fav.countrySymbol,
//                       baseSymbol: fav.baseSymbol,
//                       baseAmount: fav.baseAmount,
//                       countryName: fav.countryName,
//                       currencyName: fav.currencyName,
//                       image: fav.imageUrl,
//                       value: fav.quotePrice,
//                     );
//                   },
//                 ),
//         );
//       },
//     );
