import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {
  final Function() onPressed;
  final String message;

  const StatusButton({Key key, this.onPressed, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: onPressed == null ? Colors.grey : Colors.blue,
      child: Text(message),
    );
  }
}
