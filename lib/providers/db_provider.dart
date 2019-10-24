import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/quote.dart';

class DbProvider {
  Database _db;

  DbProvider() {
    init();
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "favorites.db");
    _db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
        CREATE TABLE Favorites
        (
          id INTEGER PRIMARY KEY,
          countryName TEXT,
          currencyName TEXT,
          baseSymbol TEXT,
          baseAmount INTEGER,
          countrySymbol TEXT,
          imageUrl TEXT
        )
      """);
    });
  }

  Future<List<Quote>> fetchItems() async {
    final List<Map<String, dynamic>> maps = await _db.query('Favorites');

    List<Quote> quotes = List.generate(maps.length, (i) {
      return Quote(
        id: maps[i]['id'],
        countrySymbol: maps[i]['countrySymbol'],
        baseSymbol: maps[i]['baseSymbol'],
        baseAmount: maps[i]['baseAmount'].toString(),
        countryName: maps[i]['countryName'],
        currencyName: maps[i]['currencyName'],
        imageUrl: maps[i]['imageUrl'],
      );
    });
    return quotes;
  }

  Future<void> insertItem(Quote quote) async {
    await _db.insert('Favorites', quote.toMap());
  }

  Future<void> deleteItem(int id) async {
    await _db.delete(
      'Favorites',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
