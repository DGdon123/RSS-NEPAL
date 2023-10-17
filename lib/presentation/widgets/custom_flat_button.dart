import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final void Function() onPressed;
  final Size size;
  final String text;
  final Color color;

  CustomRaisedButton(
      {required this.onPressed,
      required this.size,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Text(
          text,
          style: Theme.of(context).textTheme.button!.copyWith(
                fontSize: 18.0,
                color: Colors.white,
              ),
        ),
      ),
      color: color,
      highlightElevation: 0,
      elevation: 0,
      highlightColor: Colors.black,
      splashColor: Theme.of(context).colorScheme.onSecondary,
    );
  }
}
