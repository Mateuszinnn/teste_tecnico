import 'package:flutter/material.dart';
import 'package:teste_tecnico/models/produtos.dart';
import 'package:teste_tecnico/models/produtos2.dart';
import 'package:teste_tecnico/pages/produtos_page.dart';
import 'dart:math';

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
            builder: (context) => ProdutosPage(
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
                    produto is Produtos
                        ? produto.imagem != null &&
                                produto.imagem!
                                    .startsWith('http://placeimg.com/640/480/')
                            ? randomImage =
                                'https://loremflickr.com/320/240?random=${Random().nextInt(90)}'
                            : randomImage = produto.imagem ?? ''
                        : produto is Produtos2 ?
                            produto.gallery.first != null &&
                                produto.gallery!.first
                                    .startsWith('http://placeimg.com/640/480/')
                            ? randomImage =
                                'https://loremflickr.com/320/240?random=${Random().nextInt(90)}'
                            : randomImage = produto.gallery.first ?? '' : '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: (width / 2) - 45,
                child: Text(
                  produto is Produtos
                      ? produto.nome
                      : (produto as Produtos2).name,
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
                  produto is Produtos
                      ? produto.descricao
                      : (produto as Produtos2).description,
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
                child: Text(
                  'R\$ ${produto is Produtos ? produto.preco : (produto as Produtos2).price}',
                  style: const TextStyle(
                      letterSpacing: 3,
                      color: Colors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.w800),
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
