import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_tecnico/models/products_cart.dart';
import 'package:teste_tecnico/models/produtos2.dart';
import '../models/produtos.dart';

class Apis {
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<List<Produtos>> obterProdutosFornecedor1() async {
    final url = '$baseUrl/produtos1';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Produtos.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar produtos do Fornecedor 1');
    }
  }

  Future<List<Produtos2>> obterProdutosFornecedor2() async {
    final response = await http.get(Uri.parse('$baseUrl/produtos2'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Produtos2.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar produtos do Fornecedor 2');
    }
  }

  Future<List<ProductsCart>> obterProdutosCarrinho() async {
    final response = await http.get(Uri.parse('$baseUrl/carrinho'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => ProductsCart.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar produtos do Carrinho');
    }
  }

  Future<void> removerProdutoCarrinho(String id) async {
    final url = Uri.parse('$baseUrl/carrinho/$id');

    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Erro ao remover produto do carrinho');
    }
  }

  Future<List<ProductsCart>> historicoCompras() async {
    final response = await http.get(Uri.parse('$baseUrl/compra'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => ProductsCart.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar produtos de compras');
    }
  }
}
