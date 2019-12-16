import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/currency_data.dart';
import '../widgets/currency_card.dart';
import '../widgets/header_container.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _refreshCurrency(BuildContext context) async {
    await Provider.of<CurrencyData>(context, listen: false).getCurrencyData(
        baseSymbol: Provider.of<CurrencyData>(context, listen: false).base);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              HeaderContainer(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).buttonColor,
                            ),
                          );
                        } else {
                          if (snapshot.error != null) {
                            return kErrorScreen;
                          } else {
                            return RefreshIndicator(
                              onRefresh: () => _refreshCurrency(context),
                              child: Consumer<CurrencyData>(
                                  builder: (context, currencyData, child) {
                                return ListView.builder(
                                  padding: const EdgeInsets.only(top: 10),
                                  itemCount: currencyData.quoteCount,
                                  itemBuilder: ((context, i) {
                                    final quote = currencyData.quotes[i];
                                    return CurrencyCard(
                                      countryCode: quote.countrySymbol,
                                      baseSymbol: quote.baseSymbol,
                                      baseAmount: quote.baseAmount,
                                      countryName: quote.countryName,
                                      currencyName: quote.currencyName,
                                      quoteFlag: quote.quoteFlag,
                                      baseFlag: quote.baseFlag,
                                      value: quote.quotePrice,
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
      ),
    );
  }
}
