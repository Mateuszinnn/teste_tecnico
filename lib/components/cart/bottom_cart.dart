import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BottomCart extends StatefulWidget {
  final double precoTotal;
  final List<dynamic> produtoCarrinho;
  final void Function() limparCarrinho;

  const BottomCart({
    super.key,
    required this.precoTotal,
    required this.produtoCarrinho,
    required this.limparCarrinho,
  });

  @override
  State<BottomCart> createState() => _BottomCartState();
}

class _BottomCartState extends State<BottomCart> {
  Future<void> _comprar() async {
    const url = 'http://10.0.2.2:3000/compra';

    try {
      List<Map<String, dynamic>> produtosParaCompra =
          widget.produtoCarrinho.map((produto) {
        return {
          'id': produto.id,
          'nome': produto.nome,
          'preco': produto.preco,
          'imagem': produto.imagem,
        };
      }).toList();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'produtos': produtosParaCompra,
        }),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).clearSnackBars();
      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Compra realizada com sucesso!')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao realizar a compra!')),
          );
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Falha na compra!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Produto',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                      fontSize: 17,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'R\$ ${widget.precoTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Frete',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                      fontSize: 17,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Grátis',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
              height: 0.5,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'R\$ ${widget.precoTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                _comprar();
                widget.limparCarrinho();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
              ),
              child: const Text(
                '   Comprar produtos   ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
