import 'package:flutter/material.dart';

class FiltroItem extends StatelessWidget {
  final String text;
  final Color? color;

  const FiltroItem({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        letterSpacing: 3,
        color: color ?? Colors.white,
        fontSize: 17,
      ),
    );
  }
}
