import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter/planet.dart';
import 'package:projeto_flutter/planetsummary.dart';
import 'package:projeto_flutter/style.dart';

class DetailPage extends StatelessWidget {
  final Planet planet;

  DetailPage(this.planet);

  /* Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(planet.name),
              Hero(
                tag: "planet-hero-${planet.id}",
                child: Image.asset(
                  planet.image,
                  width: 96.0,
                  height: 96.0,
                ),
              )
            ],
          ), */

  @override
  Widget build(BuildContext context) {
    Container _getBackground() {
      return Container(
        child: Image.network(
          planet.picture,
          fit: BoxFit.cover,
          height: 300.0,
        ),
        constraints: BoxConstraints.expand(height: 300.0),
      );
    }

    Container _getGradient() {
      return Container(
        margin: EdgeInsets.only(top: 190.0),
        height: 110.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
          Color(0x00736AB7),
          Color(0xFF736AB7),
        ], stops: [
          0.0,
          0.9
        ], begin: FractionalOffset(0.0, 0.0), end: FractionalOffset(0.0, 1.0))),
      );
    }

    Widget _getContent() {
      final _overviewTitle = "OverView".toUpperCase();
      return ListView(
        padding: EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          PlanetSummary(planet),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _overviewTitle,
                  style: Style.headerTextStyle,
                ),
                Container(
                  margin: new EdgeInsets.symmetric(vertical: 8.0),
                  height: 2.0,
                  width: 18.0,
                  color: new Color(0xff00c6ff),
                ),
                Text(
                  planet.description,
                  style: Style.commonTextStyle,
                )
              ],
            ),
          ),
        ],
      );
    }

    Container _getToolbar(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: BackButton(
          color: Colors.white,
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: Color(0xFF736AB7),
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }
}
