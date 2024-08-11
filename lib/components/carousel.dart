import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:teste_tecnico/models/produtos.dart';
import 'package:teste_tecnico/pages/produtos_page.dart';

class Carousel extends StatefulWidget {
  final List<Produtos> produto;
  const Carousel({super.key, required this.produto});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int activeIndex = 0;
  final controller = CarouselController();
  final List<String> images = [];

  @override
  void initState() {
    super.initState();
    for (int k = 0; k < min(5, widget.produto.length); k++) {
      if (widget.produto[k].imagem.startsWith('http://placeimg.com/640/480/')) {
        images.add(
            'https://loremflickr.com/320/240?random=${Random().nextInt(90)}');
      } else {
        images.add(widget.produto[k].imagem);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdutosPage(
                  produto: widget.produto[activeIndex],
                  image: images[activeIndex],
                ),
              ),
            );
          },
          child: CarouselSlider.builder(
            carouselController: controller,
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) {
              final image = images[index];
              return buildImage(image, index);
            },
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              enlargeCenterPage: true,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(child: buildIndicator()),
      ],
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      onDotClicked: animateToSlide,
      effect: ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: Colors.white,
        dotColor: Colors.grey[500] ?? Colors.grey,
      ),
      activeIndex: activeIndex,
      count: images.length,
    );
  }

  void animateToSlide(int index) => controller.animateToPage(index);

  Widget buildImage(String imageUrl, int index) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 5,
          right: 10,
          child: Container(
            color: Colors.black,
            child: Column(
              children: [
                Text(
                  '  ${widget.produto[activeIndex].nome}  ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800
                  ),
                ),
                Text(
                  'R\$ ${widget.produto[activeIndex].preco}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 17,
                    fontWeight: FontWeight.w800
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
