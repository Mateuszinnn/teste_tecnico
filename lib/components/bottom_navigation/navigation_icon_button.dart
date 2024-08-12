import 'package:flutter/material.dart';

class NavigationIconButton extends StatelessWidget {
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;
  final String? text;

  const NavigationIconButton({
    super.key,
    this.icon,
    required this.isSelected,
    required this.onTap,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : Colors.grey[600]!.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: icon == null
                  ? Image(
                      image: AssetImage('$text', package: 'country_icons'),
                    )
                  : Icon(
                      icon,
                      size: 30,
                      color: isSelected ? Colors.black : Colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
