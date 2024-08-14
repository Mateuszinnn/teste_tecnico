import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/card_historico.dart';
import 'package:teste_tecnico/models/products_cart.dart';
import 'package:teste_tecnico/services/apis.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final Apis api = Apis();

  List<ProductsCart> produtoComprados = [];
  bool isProdutosLoaded = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistoricoCompras();
  }

  Future<void> _loadHistoricoCompras() async {
    try {
      produtoComprados = await api.historicoCompras();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isProdutosLoaded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Minhas compras',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: 3,
          ),
        ),
      ),
      body: produtoComprados.isEmpty
          ? const Center(
              child: Text(
                'Você não comprou nenhum produto.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : isProdutosLoaded
              ? isLoading
                  ? const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            color: Colors.black,
                          ),
                          Text(
                            'Carregando histórico...',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              for (int i = 0; i < produtoComprados.length; i++)
                                CardHistorico(
                                  produtoComprados: produtoComprados[i],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 77)
                      ],
                    )
              : const Center(
                  child: Text(
                    'Erro ao carregar histórico.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
    );
  }
}
