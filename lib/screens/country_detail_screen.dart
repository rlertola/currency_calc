import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class CountryDetailScreen extends StatelessWidget {
  List<double> data = [
    1,
    2,
    3,
    2,
    5,
    2,
    1,
    1,
    2,
    1,
    2,
    3,
    1,
    4,
    2,
    1,
    1,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.star_border),
        onPressed: () {},
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.network(
                'https://www.motosha.com/wp-content/uploads/mexican-flag-1024x569.jpg',
                scale: 1,
              ),
              Positioned(
                top: 40,
                left: 20,
                right: 20,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
            ),
            margin: EdgeInsets.all(50),
            height: 300,
            width: double.infinity,
            child: Sparkline(
              lineWidth: 4,
              lineColor: Colors.white,
              data: data,
              lineGradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.amber[800],
                  Colors.amber[200],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
