import 'package:flutter/material.dart';
import 'package:teste_tecnico/models/products1.dart';
import 'package:teste_tecnico/models/products2.dart';
import 'dart:math';
import 'package:teste_tecnico/pages/products_page.dart';

class InfoProdutos extends StatelessWidget {
  final double width;
  final dynamic produto;

  const InfoProdutos({
    super.key,
    required this.width,
    required this.produto,
  });

  @override
  Widget build(BuildContext context) {
    late String? randomImage;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsPage(
              produto: produto,
              image: randomImage,
            ),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: (width / 2) - 45,
                  height: 180,
                  child: Image.network(
                    produto is Products1
                        ? produto.imagem != null &&
                                produto.imagem!
                                    .startsWith('http://placeimg.com/640/480/')
                            ? randomImage =
                                'https://loremflickr.com/320/240?random=${Random().nextInt(90)}'
                            : randomImage = produto.imagem ?? ''
                        : produto is Products2
                            ? produto.gallery.first != null &&
                                    produto.gallery!.first.startsWith(
                                        'http://placeimg.com/640/480/')
                                ? randomImage =
                                    'https://loremflickr.com/320/240?random=${Random().nextInt(90)}'
                                : randomImage = produto.gallery.first ?? ''
                            : '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: (width / 2) - 45,
                child: Text(
                  produto is Products1
                      ? produto.nome
                      : (produto as Products2).name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: (width / 2) - 45,
                child: Text(
                  produto is Products1
                      ? produto.descricao
                      : (produto as Products2).description,
                  style: const TextStyle(
                    letterSpacing: 3,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: (width / 2) - 45,
                child: produto is Products1
                    ? Text(
                        'R\$ ${produto.preco}',
                        style: const TextStyle(
                          letterSpacing: 3,
                          color: Colors.green,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : (produto as Products2).hasDiscount
                        ? RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'De: ',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'R\$ ${double.tryParse(produto.price)?.toStringAsFixed(2)} \n',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const TextSpan(
                                  text: 'Por: ',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'R\$ ${(double.tryParse(produto.price)! - double.tryParse(produto.discountValue)!).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            'R\$ ${produto.price}',
                            style: const TextStyle(
                              letterSpacing: 3,
                              color: Colors.green,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
