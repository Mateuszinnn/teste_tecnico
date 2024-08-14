import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/product_page_widgets/widget_info_products_page.dart';

class ProductsPage extends StatelessWidget {
  final dynamic produto;
  final String? image;

  const ProductsPage({super.key, required this.produto, this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            //Imagem do produto no fundo
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: Image.network(
                image!,
                fit: BoxFit.cover,
              ),
            ),
            //Botao de voltar
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.black,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            //Parte inferior que mostra infos do produto
            Positioned(
                bottom: 0,
                child: WidgetInfoProductsPage(
                  produto: produto,
                  image: image,
                )),
          ],
        ),
      ),
    );
  }
}
