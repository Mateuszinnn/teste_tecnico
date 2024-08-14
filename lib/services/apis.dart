import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_tecnico/models/compra.dart';
import 'package:teste_tecnico/models/products1.dart';
import 'package:teste_tecnico/models/products2.dart';
import 'package:teste_tecnico/models/products_cart.dart';

class Apis {
  final String baseUrl = 'http://10.0.2.2:3000';

  // Obtem produtos do fornecedor 1
  Future<List<Products1>> obterProdutosFornecedor1() async {
    final url = '$baseUrl/produtos1';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Products1.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar produtos do Fornecedor 1');
    }
  }

  // Obtem produtos do fornecedor 2
  Future<List<Products2>> obterProdutosFornecedor2() async {
    final response = await http.get(Uri.parse('$baseUrl/produtos2'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Products2.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar produtos do Fornecedor 2');
    }
  }

  // Obtem produtos do carrinho
  Future<List<ProductsCart>> obterProdutosCarrinho() async {
    final response = await http.get(Uri.parse('$baseUrl/carrinho'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => ProductsCart.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar produtos do Carrinho');
    }
  }

  // Remove produtos do carrinho
  Future<void> removerProdutoCarrinho(String id) async {
    final url = Uri.parse('$baseUrl/carrinho/$id');

    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Erro ao remover produto do carrinho');
    }
  }

// Obtém histórico de compras
  Future<List<Compra>> historicoCompras() async {
    final response = await http.get(Uri.parse('$baseUrl/compra'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Compra.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar produtos de compras');
    }
  }
}
