import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/bottom_navigation/bottom_navigation.dart';
import 'package:teste_tecnico/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Ecommerce(),
    );
  }
}

class Ecommerce extends StatefulWidget {
  const Ecommerce({super.key});

  @override
  State<StatefulWidget> createState() => _Ecommerce();
}

class _Ecommerce extends State<Ecommerce> {
  int _pageIndex = 0;
  final PageController _pageController = PageController();

  void _onTabSelected(int index) {
    setState(() {
      _pageIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          children: const <Widget>[
            HomePage(),
          ],
        ),
        Positioned(
          bottom: 10,
          left: 40,
          right: 40,
          child: Bottomnavigationbar(
            pageIndex: _pageIndex,
            onTabSelected: _onTabSelected,
          ),
        ),
      ]),
    );
  }
}
