import 'package:flutter/material.dart';

// NoFavoritesScreen
const String kNoFavoritesMessage =
    'You currently have no favorites.\n\nLong-press on a card in the Home screen with any base amount to add it to your favorites.\n\n Long-press again here to remove it.';
const String kNoFavoritesImage = 'assets/star_red.png';

// CurrencyCard
const String kItemAddedToFavorites = 'Item added to favorites';
const String kItemRemovedFromFavorites = 'Item removed from favorites';

// HomeScreen and FavoritesScreen
const Center kErrorScreen = Center(
  child: Text('There was an error retrieving data'),
);
