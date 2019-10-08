import 'package:bread_currency/constants.dart';
import 'package:flutter/material.dart';

class NoFavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Image.asset(
          kNoFavoritesImage,
          color: Colors.yellow.shade200,
        ),
        Container(
          width: 330,
          child: Text(
            kNoFavoritesMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
