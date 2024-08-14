import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/carousel.dart';
import 'package:teste_tecnico/components/info_products.dart';
import 'package:teste_tecnico/components/drawer/filtro_item.dart';
import 'package:teste_tecnico/models/products1.dart';
import 'package:teste_tecnico/models/products2.dart';
class ListProducts extends StatelessWidget {
  final double totalWidth;
  final List<Products1>? produtos;
  final List<Products2>? produtos2;
  final List<Products1>? produtosFiltrados;
  final List<Products2>? produtos2Filtrados;
  final bool filtrosAtivos;
  final VoidCallback onClearFilters;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ListProducts({
    super.key,
    required this.totalWidth,
    this.produtos,
    this.produtos2,
    this.produtosFiltrados,
    this.produtos2Filtrados,
    required this.filtrosAtivos,
    required this.onClearFilters,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 20),
          if (produtos != null)
            Carousel(
              produto: produtos!,
            )
          else if (produtos2 != null)
            Carousel(
              produto2: produtos2!,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                      onClearFilters();
                    } else {
                      scaffoldKey.currentState?.openEndDrawer();
                    }
                  },
                  child: FiltroItem(
                    text: filtrosAtivos ? 'Limpar Filtros' : 'Filtrar',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          if ((produtosFiltrados?.isEmpty ?? true) &&
              (produtos2Filtrados?.isEmpty ?? true))
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
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: () {
                      onClearFilters();
                    },
                    child: const Text(
                      '  Voltar a pagina principal  ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else ...[
            if (produtosFiltrados != null)
              for (int i = 0; i < produtosFiltrados!.length; i += 2)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoProdutos(
                        width: totalWidth,
                        produto: produtosFiltrados![i],
                      ),
                      if (i + 1 < produtosFiltrados!.length)
                        InfoProdutos(
                          width: totalWidth,
                          produto: produtosFiltrados![i + 1],
                        ),
                    ],
                  ),
                ),
            if (produtos2Filtrados != null)
              for (int i = 0; i < produtos2Filtrados!.length; i += 2)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoProdutos(
                        width: totalWidth,
                        produto: produtos2Filtrados![i],
                      ),
                      if (i + 1 < produtos2Filtrados!.length)
                        InfoProdutos(
                          width: totalWidth,
                          produto: produtos2Filtrados![i + 1],
                        ),
                    ],
                  ),
                ),
          ],
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
