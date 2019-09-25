import 'package:bread_currency/models/currency_data.dart';
import 'package:bread_currency/widgets/currency_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  Future<void> _refreshFavorites(BuildContext context) async {
    print('called');
    await Provider.of<CurrencyData>(context, listen: false).updateFavorites();
  }

  @override
  Widget build(BuildContext context) {
    print('building favs');
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
                          child: Text(
                              'Longpress on a card to add it to your favorites!'),
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
