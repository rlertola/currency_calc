import 'dart:collection';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/menu_item.dart';
import '../models/quote.dart';
import 'db_provider.dart';

const String currencyDataUrl = 'https://api.exchangeratesapi.io/latest?base=';
const String defaultBaseSymbol = 'USD';

class CurrencyData extends ChangeNotifier {
  List<Quote> _quotes = [];
  List<MenuItem> _menuItems = [];
  List<Quote> _favorites = [];
  String country;
  String currency;
  String flag;
  String baseFlag;
  String base = 'USD';
  double baseAmount = 1;
  int pageIndex = 0;

  DbProvider _db = DbProvider();

  UnmodifiableListView<Quote> get quotes {
    _quotes.sort((a, b) {
      return a.countryName.compareTo(b.countryName);
    });

    return UnmodifiableListView(_quotes);
  }

  UnmodifiableListView<MenuItem> get menuItems {
    _menuItems.sort((a, b) {
      return a.countryName.compareTo(b.countryName);
    });
    return UnmodifiableListView(_menuItems);
  }

  UnmodifiableListView<Quote> get favorites {
    _favorites.sort((a, b) {
      return a.countryName.compareTo(b.countryName);
    });
    return UnmodifiableListView(_favorites);
  }

  int get quoteCount {
    return _quotes.length;
  }

  int get favCount {
    return _favorites.length;
  }

  Future<void> getCurrencyData({baseSymbol = defaultBaseSymbol}) async {
    base = baseSymbol;
    baseFlag = './assets/flags/$baseSymbol.png';
    _quotes = [];
    _menuItems = [];

    String latestQuotesUrl = '$currencyDataUrl$base';
    http.Response response = await http.get(latestQuotesUrl);
    var decoded = jsonDecode(response.body);

    double valueToRound;

    decoded['rates'].forEach((key, value) {
      setCountryInfo(key);
      valueToRound = value * baseAmount;

      _quotes.add(
        Quote(
          countrySymbol: key,
          baseSymbol: base,
          baseAmount: baseAmount.toStringAsFixed(2),
          countryName: country,
          currencyName: currency,
          quotePrice: valueToRound.toStringAsFixed(2),
          quoteFlag: flag,
          baseFlag: baseFlag,
        ),
      );

      _menuItems.add(
        MenuItem(
          currencySymbol: key,
          countryName: country,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> updateFavorites() async {
    _favorites = await _db.fetchItems();
    if (favCount == 0) {
      return;
    }

    // Refreshes the quotePrice for each favorite. Either this or await Future.forEach(...) will work. Regular forEach will not.
    for (Quote fav in _favorites) {
      double baseAmtToRound = double.parse(fav.baseAmount);
      String singleQuoteUrl =
          '$currencyDataUrl${fav.baseSymbol}&symbols=${fav.countrySymbol}';
      http.Response response = await http.get(singleQuoteUrl);
      final decoded = jsonDecode(response.body);
      double valueToRound = decoded['rates'][fav.countrySymbol];
      valueToRound = valueToRound * baseAmtToRound;
      fav.baseAmount = baseAmtToRound.toStringAsFixed(2);
      fav.quotePrice = valueToRound.toStringAsFixed(2);
    }
    notifyListeners();
  }

  void setBaseAmount(double newAmount, String baseSymbol) {
    baseAmount = newAmount;
    getCurrencyData(baseSymbol: baseSymbol);
  }

  void toggleFavorite(int quoteIndex) {
    if (pageIndex == 0) {
      _db.insertItem(_quotes[quoteIndex]);
    } else {
      _db.deleteItem(_favorites[quoteIndex].id);
      _favorites.removeAt(quoteIndex);
    }
    notifyListeners();
  }

  // BottomNavigation
  void setPageIndex(int index) {
    pageIndex = index;
  }

  void setCountryInfo(String symbol) async {
    flag = './assets/flags/$symbol.png';
    switch (symbol) {
      case 'CAD':
        country = 'Canada';
        currency = 'dollar';
        break;
      case 'HKD':
        country = 'Hong Kong';
        currency = 'dollar';
        break;
      case 'ISK':
        country = 'Iceland';
        currency = 'krona';
        break;
      case 'PHP':
        country = 'Philippines';
        currency = 'peso';
        break;
      case 'DKK':
        country = 'Denmark';
        currency = 'krone';
        break;
      case 'HUF':
        country = 'Hungary';
        currency = 'forint';
        break;
      case 'CZK':
        country = 'Czechia';
        currency = 'koruna';
        break;
      case 'GBP':
        country = 'United Kingdom';
        currency = 'pound';
        break;
      case 'RON':
        country = 'Romania';
        currency = 'leu';
        break;
      case 'SEK':
        country = 'Sweden';
        currency = 'krona';
        break;
      case 'IDR':
        country = 'Indonesia';
        currency = 'rupiah';
        break;
      case 'INR':
        country = 'India';
        currency = 'rupee';
        break;
      case 'BRL':
        country = 'Brazil';
        currency = 'real';
        break;
      case 'RUB':
        country = 'Russia';
        currency = 'rouble';
        break;
      case 'HRK':
        country = 'Croatia';
        currency = 'kuna';
        break;
      case 'JPY':
        country = 'Japan';
        currency = 'yen';
        break;
      case 'THB':
        country = 'Thailand';
        currency = 'baht';
        break;
      case 'CHF':
        country = 'Switzerland';
        currency = 'franc';
        break;
      case 'EUR':
        country = 'European Union';
        currency = 'euro';
        break;
      case 'MYR':
        country = 'Malaysia';
        currency = 'ringgit';
        break;
      case 'BGN':
        country = 'Bulgaria';
        currency = 'lev';
        break;
      case 'TRY':
        country = 'Turkey';
        currency = 'lira';
        break;
      case 'CNY':
        country = 'China';
        currency = 'yuan';
        break;
      case 'NOK':
        country = 'Norway';
        currency = 'krone';
        break;
      case 'NZD':
        country = 'New Zealand';
        currency = 'dollar';
        break;
      case 'ZAR':
        country = 'South Africa';
        currency = 'rand';
        break;
      case 'USD':
        country = 'United States';
        currency = 'dollar';
        break;
      case 'MXN':
        country = 'Mexico';
        currency = 'peso';
        break;
      case 'SGD':
        country = 'Singapore';
        currency = 'dollar';
        break;
      case 'AUD':
        country = 'Australia';
        currency = 'dollar';
        break;
      case 'ILS':
        country = 'Israel';
        currency = 'shekel';
        break;
      case 'KRW':
        country = 'South Korea';
        currency = 'won';
        break;
      case 'PLN':
        country = 'Poland';
        currency = 'zloty';
        break;
    }
  }
}
