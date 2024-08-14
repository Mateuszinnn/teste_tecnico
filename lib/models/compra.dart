import 'package:teste_tecnico/models/products_cart.dart';

class Compra {
  final String id;
  final List<ProductsCart> produtos;
  final DateTime data;

  Compra(this.id, this.produtos, this.data);

  factory Compra.fromJson(Map<String, dynamic> json) {
    // Mapeia os produtos
    var produtosJson = json['produtos'] as List;
    List<ProductsCart> produtosList = produtosJson
        .map((produto) => ProductsCart.fromJson(produto))
        .toList();

    return Compra(
      json['_id'] as String, // ID da compra
      produtosList,
      DateTime.parse(json['data'] as String).toLocal(),
    );
  }
}
