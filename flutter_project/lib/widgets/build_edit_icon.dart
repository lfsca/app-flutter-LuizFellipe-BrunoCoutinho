import 'package:flutter/material.dart';

class BuildEditIcon extends StatelessWidget {
  Color primaryColor;
  Color secondaryColor;
  Function(BuildContext) callback;

  BuildEditIcon(
      {Key? key,
      required this.primaryColor,
      required this.secondaryColor,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCircle(
      color: primaryColor,
      all: 3,
      child: buildCircle(
        color: secondaryColor,
        all: 7,
        child: IconButton(
          icon: const Icon(Icons.edit),
          color: Colors.black,
          iconSize: 32,
          //onPressed: () => print("pressionou"),
          onPressed: () => callback(context),
        ),
      ),
    );
  }
}

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
