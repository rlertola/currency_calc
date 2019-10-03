import 'dart:collection';
import 'dart:convert';

import 'package:bread_currency/models/db_provider.dart';
import 'package:bread_currency/models/menu_item.dart';
import 'package:bread_currency/models/quote.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

const String currencyDataUrl = 'https://api.exchangeratesapi.io/latest?base=';

class CurrencyData extends ChangeNotifier {
  List<Quote> _quotes = [];
  List<MenuItem> _menuItems = [];
  List<Quote> _favorites = [];
  String country;
  String currency;
  String base = 'USD';
  double baseAmount = 1;
  int pageIndex = 0;
  DbProvider db = DbProvider();

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

  Future<void> getCurrencyData({baseSymbol = 'USD'}) async {
    base = baseSymbol;
    _quotes = [];
    _menuItems = [];

    String latestQuotesUrl = '$currencyDataUrl$base';
    http.Response response = await http.get(latestQuotesUrl);
    var decoded = jsonDecode(response.body);

    double valueToRound;

    decoded['rates'].forEach((key, value) {
      valueToRound = value * baseAmount;

      setCountryInfo(key);

      _menuItems.add(
        MenuItem(
          currencySymbol: key,
          countryName: country,
        ),
      );

      _quotes.add(
        Quote(
          countrySymbol: key,
          baseSymbol: base,
          baseAmount: baseAmount.toStringAsFixed(2),
          countryName: country,
          currencyName: currency,
          quotePrice: valueToRound.toStringAsFixed(2),
          imageUrl:
              'https://www.motosha.com/wp-content/uploads/mexican-flag-1024x569.jpg',
        ),
      );
    });

    notifyListeners();
    print(quoteCount);
  }

  Future<void> updateFavorites() async {
    _favorites = await db.fetchItems();
    if (favCount == 0) {
      return;
    }
    print(favorites[0].countryName);
    // Either one of these will work. Not exactly sure why regular forEach doesn't and if one is better than the other.
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

    // await Future.forEach(_favorites, (fav) async {
    //   String singleQuoteUrl =
    //       '$currencyDataUrl${fav.baseSymbol}&symbols=${fav.countrySymbol}';
    //   http.Response response = await http.get(singleQuoteUrl);
    //   var decoded = jsonDecode(response.body);
    //   double valueToRound = decoded['rates'][fav.countrySymbol];
    //   valueToRound = valueToRound * fav.baseAmount;
    //   fav.quotePrice = valueToRound.toStringAsFixed(2);
    // });
    print(favCount);
    print('updateFavorites called');
    notifyListeners();
  }

  void setBaseAmount(double newAmount, String baseSymbol) {
    baseAmount = newAmount;
    getCurrencyData(baseSymbol: baseSymbol);
  }

  // void setFavorites(List<Map<String, dynamic>> maps) {
  //   for (Map<String, dynamic> map in maps) {
  //     _favorites.add(
  //       Quote(
  //         countrySymbol: map['countrySymbol'],
  //         baseSymbol: map['baseSymbol'],
  //         baseAmount: map['baseAmount'],
  //         countryName: map['countryName'],
  //         imageUrl: map['imageUrl'],
  //         quotePrice: map['quotePrice'],
  //       ),
  //     );
  //   }
  // }

  void toggleFavorite(int quoteIndex) {
    if (pageIndex == 0) {
      // _favorites.add(_quotes[quoteIndex]);
      db.insertItem(_quotes[quoteIndex]);
    } else {
      print('toggle deleted $quoteIndex');
      _favorites.removeAt(quoteIndex);
      db.deleteItem(quoteIndex);
    }
    notifyListeners();
  }

  void setPageIndex(int index) {
    pageIndex = index;
  }

  void setCountryInfo(String symbol) {
    switch (symbol) {
      case 'CAD':
        country = 'Canada';
        currency = 'Canadian dollar';
        break;
      case 'HKD':
        country = 'Hong Kong';
        currency = 'Hong Kong dollar';
        break;
      case 'ISK':
        country = 'Iceland';
        currency = 'Icelandic krona';
        break;
      case 'PHP':
        country = 'Phillippines';
        currency = 'Phillippine peso';
        break;
      case 'DKK':
        country = 'Denmark';
        currency = 'Danish krone';
        break;
      case 'HUF':
        country = 'Hungary';
        currency = 'Hungarian forint';
        break;
      case 'CZK':
        country = 'Czechia';
        currency = 'Czech koruna';
        break;
      case 'GBP':
        country = 'United Kingdom';
        currency = 'British pound';
        break;
      case 'RON':
        country = 'Romania';
        currency = 'Romanian leu';
        break;
      case 'SEK':
        country = 'Sweden';
        currency = 'Swedish krona';
        break;
      case 'IDR':
        country = 'Indonesia';
        currency = 'Indonesian rupiah';
        break;
      case 'INR':
        country = 'India';
        currency = 'Indian rupee';
        break;
      case 'BRL':
        country = 'Brazil';
        currency = 'Brazilian real';
        break;
      case 'RUB':
        country = 'Russia';
        currency = 'Russian ruble';
        break;
      case 'HRK':
        country = 'Croatia';
        currency = 'Croatian kuna';
        break;
      case 'JPY':
        country = 'Japan';
        currency = 'Japanese yen';
        break;
      case 'THB':
        country = 'Thailand';
        currency = 'Thai baht';
        break;
      case 'CHF':
        country = 'Switzerland';
        currency = 'Swiss franc';
        break;
      case 'EUR':
        country = 'European Union';
        currency = 'euro';
        break;
      case 'MYR':
        country = 'Malaysia';
        currency = 'Malaysian ringgit';
        break;
      case 'BGN':
        country = 'Bulgaria';
        currency = 'Bulgarian lev';
        break;
      case 'TRY':
        country = 'Turkey';
        currency = 'Turkish lira';
        break;
      case 'CNY':
        country = 'China';
        currency = 'Chinese yuan';
        break;
      case 'NOK':
        country = 'Norway';
        currency = 'Norwegian krone';
        break;
      case 'NZD':
        country = 'New Zealand';
        currency = 'New Zealand dollar';
        break;
      case 'ZAR':
        country = 'South Africa';
        currency = 'South African rand';
        break;
      case 'USD':
        country = 'United States';
        currency = 'US dollar';
        break;
      case 'MXN':
        country = 'Mexico';
        currency = 'Mexican peso';
        break;
      case 'SGD':
        country = 'Singapore';
        currency = 'Singapore dollar';
        break;
      case 'AUD':
        country = 'Australia';
        currency = 'Australian dollar';
        break;
      case 'ILS':
        country = 'Israel';
        currency = 'Israeli shekel';
        break;
      case 'KRW':
        country = 'South Korea';
        currency = 'South Korean won';
        break;
      case 'PLN':
        country = 'Poland';
        currency = 'Polish zloty';
        break;
    }
  }
}
