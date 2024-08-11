import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:teste_tecnico/models/produtos.dart';
import 'package:teste_tecnico/models/produtos2.dart';

class Apis {
  final String produtosFornecedor1 =
      "http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/brazilian_provider";
  final String produtosFornecedor2 =
      "http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/european_provider";

  Future<List<Produtos>> obterProdutosFornecedor1() async {
    final http.Response response =
        await http.get(Uri.parse(produtosFornecedor1));
    final data = json.decode(response.body);
    List<Produtos> produtos =
        List<Produtos>.from(data.map((model) => Produtos.fromJson(model)));
    return produtos;
  }

  Future<List<Produtos2>> obterProdutosFornecedor2() async {
    final http.Response response =
        await http.get(Uri.parse(produtosFornecedor2));
    final data = json.decode(response.body);
    List<Produtos2> produtos2 =
        List<Produtos2>.from(data.map((model) => Produtos2.fromJson(model)));
    return produtos2;
  }
}
