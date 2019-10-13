import 'package:bread_currency/constants.dart';
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
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            HeaderContainer(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 12,
                    left: 12,
                  ),
                  child: FutureBuilder(
                    future: _refreshCurrency(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        );
                      } else {
                        if (snapshot.error != null) {
                          return Center(
                            child: Text(kErrorMessage),
                          );
                        } else {
                          return RefreshIndicator(
                            onRefresh: () => _refreshCurrency(context),
                            child: Consumer<CurrencyData>(
                                builder: (context, currencyData, child) {
                              return ListView.builder(
                                padding: EdgeInsets.only(top: 10),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
