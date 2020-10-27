import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  IconData iconData;
  VoidCallback onPressed;
  double size;
  double height;
  double width;
  CustomRaisedButton(
      {this.iconData, this.onPressed, this.size, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Colors.grey[700],
          onPressed: onPressed,
          child: Icon(iconData, size: size, color: Colors.white)),
    );
  }
}
