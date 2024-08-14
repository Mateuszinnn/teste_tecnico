import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/custom_search_bar.dart';
import 'package:teste_tecnico/components/drawer/custom_drawer2.dart';
import 'package:teste_tecnico/components/list_products.dart';
import 'package:teste_tecnico/models/products2.dart';
import 'package:teste_tecnico/services/Apis.dart';

class EuropeProductsPage extends StatefulWidget {
  const EuropeProductsPage({super.key});

  @override
  State<EuropeProductsPage> createState() => _EuropeProductsPageState();
}

class _EuropeProductsPageState extends State<EuropeProductsPage> {
  final Apis api = Apis();
  List<Products2> produtos2 = [];
  List<Products2> produtosFiltrados = [];
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
      isloading = false;
    } catch (e) {
      setState(() {
        failLoad = true;
      });
    }
  }

  void _applyFilters(
    bool hasDiscountChecked,
    Map<String, bool> materialChecked,
    Map<String, bool> adjectiveChecked,
    String precoMin,
    String precoMax,
  ) {
    setState(() {
      produtosFiltrados = produtos2.where((produto) {
        // Obtendo se cada filtro está ativo
        bool matchDiscount = hasDiscountChecked ? produto.hasDiscount : true;
        bool matchMaterial = materialChecked[produto.material] ?? false;
        bool matchAdjective = adjectiveChecked[produto.adjective] ?? false;
        double precoMini = double.tryParse(precoMin) ?? 0;
        double precoMaxi = double.tryParse(precoMax) ?? double.infinity;
        bool matchPreco = (double.tryParse(produto.price)! >= precoMini &&
            double.tryParse(produto.price)! <= precoMaxi);

        // Verifica se o produto atende aos filtros ativos
        bool matchesFilters = true;
        if (hasDiscountChecked) {
          matchesFilters = matchesFilters && matchDiscount;
        }
        if (materialChecked.containsValue(true)) {
          matchesFilters = matchesFilters && matchMaterial;
        }
        if (adjectiveChecked.containsValue(true)) {
          matchesFilters = matchesFilters && matchAdjective;
        }
        return matchesFilters && matchPreco;
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

  void _cancelSearch() {
    setState(() {
      produtosFiltrados = List.from(produtos2);
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        key: _scaffoldKey,
        //App bar
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
            //Se falhar na requisição dos dados => 'Falha na requisição dos dados!'
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
            //Se obtiver os dados comeca a carregar a pagina
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
                //Quando carregar mostra a barra de pesquisa e os produtos
                : Container(
                    color: Colors.black,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          //Barra de pesquisa
                          child: CustomSearchBar(
                            isExpanded: isExpanded,
                            onExpand: _expandSearchBar,
                            onCollapse: _collapseSearchBar,
                            searchFilters: _searchFilters,
                            cancelSearch: _cancelSearch,
                          ),
                        ),
                        const SizedBox(height: 10),
                        //Lista de produtos
                        ListProducts(
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
        //Drawer
        endDrawer: CustomDrawer2(
          onApplyFilters: _applyFilters,
        ),
      ),
    );
  }
}
