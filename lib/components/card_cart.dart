import 'package:flutter/material.dart';
import 'package:teste_tecnico/models/products_cart.dart';
import 'package:teste_tecnico/services/apis.dart';

class CardCart extends StatelessWidget {
  final ProductsCart produtoCarrinho;
  final VoidCallback onRemove; 

  const CardCart({super.key, required this.produtoCarrinho, required this.onRemove});

  Future<void> _removerProdutoCarrinho(String id) async {
    try {
      await Apis().removerProdutoCarrinho(id);
      onRemove(); 
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao remover produto: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width - 30,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        produtoCarrinho.imagem,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      produtoCarrinho.nome,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _removerProdutoCarrinho(produtoCarrinho.id);
                    },
                    child: const Text(
                      'Remover',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ${produtoCarrinho.preco}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
