import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/custom_search_bar.dart';
import 'package:teste_tecnico/components/drawer/custom_drawer.dart';
import 'package:teste_tecnico/components/lista_produtos.dart';
import 'package:teste_tecnico/models/produtos2.dart';
import 'package:teste_tecnico/services/Apis.dart';

class EuropeProductsPage extends StatefulWidget {
  const EuropeProductsPage({super.key});

  @override
  State<EuropeProductsPage> createState() => _EuropeProductsPageState();
}

class _EuropeProductsPageState extends State<EuropeProductsPage> {
 final Apis api = Apis();
  List<Produtos2> produtos2 = [];
  List<Produtos2> produtosFiltrados = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool filtrosAtivos = false;
  bool isloading = true;
  bool failLoad = false;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadProdutos();
  }

  Future<void> _loadProdutos() async {
    try {
      produtos2 = await api.obterProdutosFornecedor2();
      produtosFiltrados = List.from(produtos2);
      setState(() {});
      _printProdutos2(produtos2, 5);
      isloading = false;
    } catch (e) {
      setState(() {
        failLoad = true;
      });
    }
  }

  void _applyFilters(
    Map<String, bool> discountChecked,
    Map<String, bool> materialChecked,
    Map<String, bool> adjectiveChecked,
    String precoMin,
    String precoMax,
  ) {
    setState(() {
      produtosFiltrados = produtos2.where((produto2) {
        bool matchDiscount = discountChecked[produto2.hasDiscount.toString()] ?? false;
        bool matchMaterial = materialChecked[produto2.material] ?? false;
        bool matchAdjective = adjectiveChecked[produto2.adjective] ?? false;
        double precoMini = double.tryParse(precoMin) ?? 0;
        double precoMaxi = double.tryParse(precoMax) ?? double.infinity;

        bool matchPreco = (double.tryParse(produto2.price)! >= precoMini &&
            double.tryParse(produto2.price)! <= precoMaxi);

        return (matchDiscount || matchMaterial || matchAdjective) &&
            matchPreco;
      }).toList();
      filtrosAtivos = produtosFiltrados.isNotEmpty;
    });
  }

  void _searchFilters(String nomeProduto) {
    setState(() {
      produtosFiltrados = produtos2.where((produto2) {
        return produto2.name.toLowerCase().contains(nomeProduto.toLowerCase());
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      produtosFiltrados = List.from(produtos2);
      filtrosAtivos = false;
    });
  }

  void _expandSearchBar() {
    setState(() {
      isExpanded = true;
    });
  }

  void _collapseSearchBar() {
    setState(() {
      isExpanded = false;
    });
  }

  void _printProdutos2(List<Produtos2> produtos2, int quantidade) {
    int i = 0;
    for (var produtos2 in produtos2) {
      // ignore: avoid_print
      print('\n');
      // ignore: avoid_print
      print('desconto: ${produtos2.hasDiscount}');
      // ignore: avoid_print
      print('nome: ${produtos2.name}');
      // ignore: avoid_print
      print('galeria: ${produtos2.gallery}');
      // ignore: avoid_print
      print('descricao: ${produtos2.description}');
      // ignore: avoid_print
      print('preco: ${produtos2.price}');
      // ignore: avoid_print
      print('valor desconto: ${produtos2.discountValue}');
      // ignore: avoid_print
      print('adjetivo: ${produtos2.adjective}');
      // ignore: avoid_print
      print('material: ${produtos2.material}');
      // ignore: avoid_print
      print('id: ${produtos2.id}');
      // ignore: avoid_print
      print('\n');
      if (i >= quantidade) break;
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Import Products',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: failLoad
            ? Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: Text(
                    'Falha na requisição dos dados!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : isloading
                ? Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Carregando produtos...',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  )
                : Container(
                    color: Colors.black,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: CustomSearchBar(
                            isExpanded: isExpanded,
                            onExpand: _expandSearchBar,
                            onCollapse: _collapseSearchBar,
                            searchFilters: _searchFilters,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListaProdutos(
                          totalWidth: totalWidth,
                          produtos2: produtos2,
                          produtos2Filtrados: produtosFiltrados,
                          filtrosAtivos: filtrosAtivos,
                          onClearFilters: _clearFilters,
                          scaffoldKey: _scaffoldKey,
                        ),
                      ],
                    ),
                  ),
        endDrawer: CustomDrawer(
          onApplyFilters: _applyFilters,
        ),
      ),
    );
  }
}