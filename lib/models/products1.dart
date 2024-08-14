//Modelo para produtos do fornecedor 1

class Products1 {
  final String nome;
  final String descricao;
  final String categoria;
  final String imagem;
  final String preco;
  final String material;
  final String departamento;
  final String id;

  Products1(
    this.nome, 
    this.descricao, 
    this.categoria, 
    this.imagem, 
    this.preco,
    this.material, 
    this.departamento, 
    this.id,
  );

  factory Products1.fromJson(dynamic data) {
    return Products1(
      data['nome'] as String,
      data['descricao'] as String,
      data['categoria'] as String,
      data['imagem'] as String,
      data['preco'] as String,
      data['material'] as String,
      data['departamento'] as String,
      data['id'] as String,
    );
  }
}
