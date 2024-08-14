import 'package:flutter/material.dart';
import 'package:teste_tecnico/models/products1.dart';
import 'package:teste_tecnico/models/products2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WidgetInfoProductsPage extends StatefulWidget {
  final dynamic produto;
  final String? image;
  const WidgetInfoProductsPage({
    super.key,
    this.produto,
    this.image,
  });

  @override
  State<WidgetInfoProductsPage> createState() => _WidgetInfoProductsPageState();
}

class _WidgetInfoProductsPageState extends State<WidgetInfoProductsPage> {
  bool _isExpanded = false;

  Future<void> _addToCart() async {
    const url = 'http://10.0.2.2:3000/carrinho';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': widget.produto is Products1
              ? widget.produto.id
              : (widget.produto as Products2).id,
          'imagem': widget.produto is Products1 ? widget.image! : widget.image!,
          'nome': widget.produto is Products1
              ? widget.produto.nome
              : (widget.produto as Products2).name,
          'preco': widget.produto is Products1
              ? widget.produto.preco
              : (widget.produto as Products2).price,
        }),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).clearSnackBars();
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produto adicionado ao carrinho!'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao adicionar o produto!')),
        );
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha na requisição!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.produto is Products1
                    ? widget.produto.nome
                    : (widget.produto as Products2).name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.produto is Products1
                    ? widget.produto.descricao
                    : (widget.produto as Products2).description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            widget.produto is Products1
                ? Text(
                    'R\$ ${widget.produto.preco}',
                    style: const TextStyle(
                      letterSpacing: 3,
                      color: Colors.green,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : (widget.produto as Products2).hasDiscount
                    ? RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'De: ',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'R\$ ${double.tryParse(widget.produto.price)?.toStringAsFixed(2)} \n',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const TextSpan(
                              text: 'Por: ',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'R\$ ${(double.tryParse(widget.produto.price)! - double.tryParse(widget.produto.discountValue)!).toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        'R\$ ${widget.produto.price}',
                        style: const TextStyle(
                          letterSpacing: 3,
                          color: Colors.green,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width - 23.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: ExpansionPanelList(
                  elevation: 0,
                  expandIconColor: Colors.white,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      backgroundColor: Colors.grey[900]!.withOpacity(0.5),
                      headerBuilder: (context, isOpen) {
                        return const Padding(
                          padding: EdgeInsets.only(left: 12.5, top: 12.5),
                          child: Text(
                            'Ficha técnica',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                      body: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.produto is Products1) ...[
                              Text(
                                'Departamento do Produto: ${widget.produto.departamento}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Material do Produto: ${widget.produto.material}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Categoria do Produto: ${widget.produto.categoria}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ] else if (widget.produto is Products2) ...[
                              if (widget.produto.hasDiscount)
                                Text(
                                  'Desconto do Produto: ${widget.produto.discountValue} reais',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              Text(
                                'Material do Produto: ${widget.produto.material}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Adjetivo do Produto: ${widget.produto.adjective}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ],
                        ),
                      ),
                      isExpanded: _isExpanded,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width - 23.5,
              child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: _addToCart,
                child: const Text(
                  'Adicionar ao carrinho',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
