//Modelo para produtos no carrinho
class ProductsCart {
  final String id;
  final String nome;
  final String imagem;
  final String preco;

  ProductsCart(
    this.id,
    this.nome,
    this.imagem,
    this.preco,
  );

  factory ProductsCart.fromJson(dynamic data) {
    return ProductsCart(
      data['id'] as String,
      data['nome'] as String,
      data['imagem'] as String,
      data['preco'] as String,
    );
  }
}
