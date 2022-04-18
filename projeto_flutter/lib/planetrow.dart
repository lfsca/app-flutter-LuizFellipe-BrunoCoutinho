import 'package:flutter/material.dart';
import 'package:projeto_flutter/detailpage.dart';
import 'package:projeto_flutter/planet.dart';
import 'package:projeto_flutter/style.dart';

class PlanetRow extends StatelessWidget {
  final Planet planet;

  PlanetRow(this.planet);

  @override
  Widget build(BuildContext context) {
    Widget _planetValue({String value, String image}) {
      return Row(children: <Widget>[
        Image.asset(image, height: 12.0),
        Container(width: 8.0),
        Text(planet.gravity, style: Style.regularTextStyle),
      ]);
    }

    final planetThumb = Container(
      margin: EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      alignment: FractionalOffset.centerLeft,
      child: Hero(
        tag: "planet-hero-${planet.id}",
        child: Image.asset(
          planet.image,
          width: 96.0,
          height: 96.0,
        ),
      ),
    );

    final planetCardContent = new Container(
      margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      //constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 4.0),
          Text(
            planet.name,
            style: Style.headerTextStyle,
          ),
          Container(height: 8.0),
          Text(planet.location, style: Style.subHeaderTextStyle),
          Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 180.0,
              color: Color(0xff00c6ff)),
          Row(
            children: <Widget>[
              Expanded(
                  child: _planetValue(
                      value: planet.distance,
                      image: 'assets/img/ic_distance.png')),
              Expanded(
                  child: _planetValue(
                      value: planet.gravity,
                      image: 'assets/img/ic_gravity.png'))
            ],
          )
        ],
      ),
    );

    final planetCard = Container(
      child: planetCardContent,
      constraints: BoxConstraints.expand(),
      height: 128.0,
      margin: EdgeInsets.only(
        left: 46.0,
      ),
      decoration: BoxDecoration(
          color: Color(0xFF333366),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ]),
    );

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => DetailPage(planet),
        ),
      ),
      child: Container(
        height: 128.0,
        margin: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            planetCard,
            planetThumb,
          ],
        ),
      ),
    );
  }
}
