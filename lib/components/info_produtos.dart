import 'package:flutter/material.dart';
import 'package:teste_tecnico/models/produtos.dart';
import 'package:teste_tecnico/pages/produtos_page.dart';
import 'dart:math';

class InfoProdutos extends StatelessWidget {
  final double width;
  final Produtos produto;

  const InfoProdutos({
    super.key,
    required this.width,
    required this.produto,
  });
  

  @override
  Widget build(BuildContext context) {
    final String? randomImage;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdutosPage(produto: produto, image: randomImage),
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
                    produto.imagem.startsWith('http://placeimg.com/640/480/')
                        ? randomImage = 'https://loremflickr.com/320/240?random=${Random().nextInt(90)}'
                        : randomImage = produto.imagem,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: (width / 2) - 45,
                child: Text(
                  produto.nome,
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
                  produto.descricao,
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
                  'R\$ ${produto.preco}',
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
