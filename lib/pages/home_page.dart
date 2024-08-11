import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/carousel.dart';
import 'package:teste_tecnico/components/drawer/custom_drawer.dart';
import 'package:teste_tecnico/components/filtro_item.dart';
import 'package:teste_tecnico/components/info_produtos.dart';
import 'package:teste_tecnico/main.dart';
import 'package:teste_tecnico/models/produtos.dart';
import 'package:teste_tecnico/models/produtos2.dart';
import 'package:teste_tecnico/services/Apis.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Apis api = Apis();
  List<Produtos> produtos = [];
  List<Produtos2> produtos2 = [];
  List<Produtos> produtosFiltrados = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool filtrosAtivos = false;
  bool isloading = true;
  bool failLoad = false;

  @override
  void initState() {
    super.initState();
    _loadProdutos();
  }

  Future<void> _loadProdutos() async {
    try {
      produtos = await api.obterProdutosFornecedor1();
      produtos2 = await api.obterProdutosFornecedor2();
      produtosFiltrados = List.from(produtos);
      setState(() {});
      _printProdutos(produtos, 0);
      _printProdutos2(produtos2, 5);
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
        bool matchDepartamento =
            departamentosChecked[produto.departamento] ?? false;
        bool matchMaterial = materialChecked[produto.material] ?? false;
        bool matchCategoria = categoriaChecked[produto.categoria] ?? false;
        double precoMini = double.tryParse(precoMin) ?? 0;
        double precoMaxi = double.tryParse(precoMax) ?? double.infinity;

        bool matchPreco = (double.tryParse(produto.preco)! >= precoMini && double.tryParse(produto.preco)! <= precoMaxi);

        return (matchDepartamento || matchMaterial || matchCategoria) && matchPreco;
      }).toList();
      filtrosAtivos = produtosFiltrados.isNotEmpty;
    });
  }

  void _clearFilters() {
    setState(() {
      produtosFiltrados = List.from(produtos);
      filtrosAtivos = false;
    });
  }

  void _printProdutos(List<Produtos> produtos, int quantidade) {
    int i = 0;
    for (var produtos in produtos) {
      // ignore: avoid_print
      print('\n');
      // ignore: avoid_print
      print('nome: ${produtos.nome}');
      // ignore: avoid_print
      print('descricao: ${produtos.descricao}');
      // ignore: avoid_print
      print('categoria: ${produtos.categoria}');
      // ignore: avoid_print
      print('imagem: ${produtos.imagem}');
      // ignore: avoid_print
      print('preco: ${produtos.preco}');
      // ignore: avoid_print
      print('material: ${produtos.material}');
      // ignore: avoid_print
      print('departamento: ${produtos.departamento}');
      // ignore: avoid_print
      print('id: ${produtos.id}');
      // ignore: avoid_print
      print('\n');
      if (i >= quantidade) break;
      i++;
    }
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
            'Browse for Products',
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
                color: Colors.white,
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
                          'Carregando...',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ],
                    ),
                  )
                : Container(
                    color: Colors.black,
                    child: Column(
                      children: [
                        Flexible(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              const SizedBox(height: 20),
                              Carousel(
                                produto: produtos,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: FiltroItem(
                                        text: 'Popular',
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        if (filtrosAtivos) {
                                          _clearFilters();
                                        } else {
                                          _scaffoldKey.currentState
                                              ?.openEndDrawer();
                                        }
                                      },
                                      child: FiltroItem(
                                        text: filtrosAtivos
                                            ? 'Limpar Filtros'
                                            : 'Filtrar',
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (produtosFiltrados.isEmpty)
                                Column(
                                  children: [
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          'Nenhum produto encontrado!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Ecommerce()));
                                    }, child: const Text('Voltar a pagina principal'))
                                  ],
                                )
                              else ...[
                                for (int i = 0;
                                    i < produtosFiltrados.length;
                                    i += 2)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InfoProdutos(
                                          width: totalWidth,
                                          produto: produtosFiltrados[i],
                                        ),
                                        if (i + 1 < produtosFiltrados.length)
                                          InfoProdutos(
                                            width: totalWidth,
                                            produto: produtosFiltrados[i + 1],
                                          ),
                                      ],
                                    ),
                                  ),
                              ],
                              const SizedBox(height: 70),
                            ],
                          ),
                        )
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
