import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/bottom_cart.dart';
import 'package:teste_tecnico/components/card_cart.dart';
import 'package:teste_tecnico/models/products_cart.dart';
import 'package:teste_tecnico/services/apis.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Apis api = Apis();
  List<ProductsCart> produtoCarrinho = [];
  bool isLoading = true;
  bool isProdutosLoaded = true;

  @override
  void initState() {
    super.initState();
    _loadProdutosCarrinho();
  }

  Future<void> _loadProdutosCarrinho() async {
    try {
      produtoCarrinho = await api.obterProdutosCarrinho();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isProdutosLoaded = false;
      });
    }
  }

  void _esvaziarCarrinho() async {
    setState(() {
      produtoCarrinho.clear();
    });
  }

  double _calcularPrecoTotal() {
    double total = 0;
    for (var produto in produtoCarrinho) {
      total += double.tryParse(produto.preco) ?? 0.0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Carrinho de compras',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: 3,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
          width: width,
          color: Colors.grey[500],
          child: isProdutosLoaded
              ? isLoading
                  ? const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          Text(
                            'O carrinho está vazio.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : produtoCarrinho.isNotEmpty
                      ? Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                    children: [
                                      for (int i = 0;
                                          i < produtoCarrinho.length;
                                          i++)
                                        CardCart(
                                          produtoCarrinho: produtoCarrinho[i],
                                          onRemove: () {
                                            setState(() {
                                              produtoCarrinho.removeAt(i);
                                            });
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 275),
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: BottomCart(
                                precoTotal: _calcularPrecoTotal(),
                                produtoCarrinho: produtoCarrinho,
                                limparCarrinho: _esvaziarCarrinho,
                              ),
                            ),
                          ],
                        )
                      : const Center(
                          child: Text(
                            'O carrinho está vazio.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
              : const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      Text(
                        'Erro em carregar produtos.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
