import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String msg;
  final double marginLeft;
  const ErrorView(this.msg, {Key? key, this.marginLeft = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, left: marginLeft),
      child: Text(
        msg,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
      ),
    );
  }
}
