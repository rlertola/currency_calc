import 'package:flutter/material.dart';

import '../constants.dart';

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
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
