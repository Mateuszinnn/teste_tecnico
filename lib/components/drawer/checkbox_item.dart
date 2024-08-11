import 'package:flutter/material.dart';

class CheckboxItem extends StatelessWidget {
  const CheckboxItem({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  final String text;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Checkbox(
            focusColor: Colors.white,
            hoverColor: Colors.white,
            side: const BorderSide(color: Colors.white),
            activeColor: Colors.white,
            checkColor: Colors.black,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
