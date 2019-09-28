import 'package:flutter/material.dart';

import 'package:bread_currency/widgets/currency_card.dart';
import 'package:bread_currency/widgets/header_container.dart';
import 'package:bread_currency/models/currency_data.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _refreshCurrency(BuildContext context) async {
    await Provider.of<CurrencyData>(context, listen: false).getCurrencyData(
        baseSymbol: Provider.of<CurrencyData>(context, listen: false).base);
  }

  @override
  Widget build(BuildContext context) {
    print('building all list');
    return Scaffold(
      body: Column(
        children: <Widget>[
          HeaderContainer(),
          Expanded(
            child: FutureBuilder(
              future: _refreshCurrency(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.error != null) {
                    return Center(
                      child: Text('There was an error retrieving data.'),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () => _refreshCurrency(context),
                      child: Consumer<CurrencyData>(
                          builder: (context, currencyData, child) {
                        return ListView.builder(
                          itemCount: currencyData.quoteCount,
                          itemBuilder: ((context, i) {
                            final quote = currencyData.quotes[i];
                            return CurrencyCard(
                              countryCode: quote.countrySymbol,
                              baseSymbol: quote.baseSymbol,
                              baseAmount: quote.baseAmount,
                              countryName: quote.countryName,
                              currencyName: quote.currencyName,
                              image: quote.imageUrl,
                              value: snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? 'CircularProgressIndicator()'
                                  : quote.quotePrice,
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
          ),
        ],
      ),
    );
  }
}
