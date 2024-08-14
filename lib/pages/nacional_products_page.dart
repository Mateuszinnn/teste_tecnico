import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/custom_search_bar.dart';
import 'package:teste_tecnico/components/drawer/custom_drawer.dart';
import 'package:teste_tecnico/components/list_products.dart';
import 'package:teste_tecnico/models/products1.dart';
import 'package:teste_tecnico/services/Apis.dart';

class NacionalProductsPage extends StatefulWidget {
  const NacionalProductsPage({super.key});

  @override
  State<NacionalProductsPage> createState() => _HomePageState();
}

class _HomePageState extends State<NacionalProductsPage> {
  final Apis api = Apis();
  List<Products1> produtos = [];
  List<Products1> produtosFiltrados = [];
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
      produtos = await api.obterProdutosFornecedor1();
      produtosFiltrados = List.from(produtos);
      setState(() {});
      isloading = false;
    } catch (e) {
      setState(() {
        failLoad = true;
      });
    }
  }

  void _applyFilters(
    Map<String, bool> departamentosChecked,
    Map<String, bool> materialChecked,
    Map<String, bool> categoriaChecked,
    String precoMin,
    String precoMax,
  ) {
    setState(() {
      produtosFiltrados = produtos.where((produto) {
        // Obtendo se cada filtro está ativo
        bool matchDepartamento =
            departamentosChecked[produto.departamento] ?? false;
        bool matchMaterial = materialChecked[produto.material] ?? false;
        bool matchCategoria = categoriaChecked[produto.categoria] ?? false;
        double precoMini = double.tryParse(precoMin) ?? 0;
        double precoMaxi = double.tryParse(precoMax) ?? double.infinity;
        bool matchPreco = (double.tryParse(produto.preco)! >= precoMini &&
            double.tryParse(produto.preco)! <= precoMaxi);

        // Verifica se o produto atende aos filtros ativos
        bool matchesFilters = true;
        if (departamentosChecked.containsValue(true)) {
          matchesFilters = matchesFilters && matchDepartamento;
        }
        if (materialChecked.containsValue(true)) {
          matchesFilters = matchesFilters && matchMaterial;
        }
        if (categoriaChecked.containsValue(true)) {
          matchesFilters = matchesFilters && matchCategoria;
        }
        return matchesFilters && matchPreco;
      }).toList();
      filtrosAtivos = produtosFiltrados.isNotEmpty;
    });
  }

  void _searchFilters(String nomeProduto) {
    setState(() {
      produtosFiltrados = produtos.where((produto) {
        return produto.nome.toLowerCase().contains(nomeProduto.toLowerCase());
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      produtosFiltrados = List.from(produtos);
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
      produtosFiltrados = List.from(produtos);
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      bottom: false,
      top: false,
      //App Bar
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Nacional Products',
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
                          produtos: produtos,
                          produtosFiltrados: produtosFiltrados,
                          filtrosAtivos: filtrosAtivos,
                          onClearFilters: _clearFilters,
                          scaffoldKey: _scaffoldKey,
                        ),
                      ],
                    ),
                  ),
        //Drawer
        endDrawer: CustomDrawer(
          onApplyFilters: _applyFilters,
        ),
      ),
    );
  }
}
