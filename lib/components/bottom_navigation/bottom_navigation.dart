import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/bottom_navigation/navigation_icon_button.dart';

class Bottomnavigationbar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTabSelected;

  const Bottomnavigationbar({
    super.key,
    required this.pageIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
          child: Container(
            color: Colors.grey[700]!.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NavigationIconButton(
                  isSelected: pageIndex == 0,
                  icon: pageIndex == 0 ? Icons.home : Icons.home_outlined,
                  onTap: () => onTabSelected(0),
                ),
                const Spacer(),
                NavigationIconButton(
                  isSelected: pageIndex == 1,
                  icon: pageIndex == 1 ? Icons.search : Icons.search,
                  onTap: () => onTabSelected(1),
                ),
                const Spacer(),
                NavigationIconButton(
                  isSelected: pageIndex == 2,
                  icon: pageIndex == 2
                      ? Icons.shopping_cart_rounded
                      : Icons.shopping_cart_outlined,
                  onTap: () => onTabSelected(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
