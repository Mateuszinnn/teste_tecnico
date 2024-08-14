import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/cart_page_widgets/card_history.dart';
import 'package:teste_tecnico/models/compra.dart';
import 'package:teste_tecnico/services/apis.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final Apis api = Apis();
  List<Compra> compras = [];
  bool isProdutosLoaded = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistorico();
  }

  Future<void> _loadHistorico() async {
    try {
      List<Compra> historicoCompras  = await api.historicoCompras();
      setState(() {
        isLoading = false;
        compras = historicoCompras;
      });
    } catch (e) {
      setState(() {
        isProdutosLoaded = false;
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
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
      body: compras.isEmpty
          //Se o usuario nao comprou produtos mostra a mensagem: 'Você não comprou nenhum produto.'
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
          //Se comprou produtos verifica se os produtos foram obtidos
          : isProdutosLoaded
              //Se foram obtidos comeca o carregamento da pagina
              ? isLoading
                  //enquanto carrega
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
                  //Depois de carregar mostra os produtos comprados
                  : Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              for (int i = 0; i < compras.length; i++)
                                CardHistory(
                                  compra: compras[i],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 77)
                      ],
                    )
              //Se nao obtiver os produtos => 'Erro ao carregar histórico.'
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
