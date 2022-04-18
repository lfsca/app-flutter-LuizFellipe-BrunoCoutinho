import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter/planet.dart';
import 'package:projeto_flutter/style.dart';

class PlanetSummary extends StatelessWidget {
  final Planet planet;

  PlanetSummary(this.planet);

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
      alignment: FractionalOffset.center,
      child: Hero(
        tag: "planet-hero-${planet.id}",
        child: Image.asset(
          planet.image,
          height: 92.0,
          width: 92.0,
        ),
      ),
    );

    final planetCardContent = Container(
      margin: EdgeInsets.fromLTRB(16.0, 42.0, 16.0, 16.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 4.0,
          ),
          Text(
            planet.name,
            style: Style.headerTextStyle,
          ),
          Container(
            height: 10.0,
          ),
          Text(planet.location, style: Style.subHeaderTextStyle),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 180.0,
            color: Color(0xFF00C6FF),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 0,
                child: _planetValue(
                  value: planet.distance,
                  image: 'assets/img/ic_distance.png',
                ),
              ),
              Container(
                width: 32.0,
              ),
              Expanded(
                flex: 0,
                child: _planetValue(
                  value: planet.gravity,
                  image: 'assets/img/ic_gravity.png',
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final planetCard = Container(
      child: planetCardContent,
      height: 154.0,
      margin: EdgeInsets.only(
        top: 72.0,
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
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Stack(
        children: [
          planetCard,
          planetThumb,
        ],
      ),
    );
  }
}
