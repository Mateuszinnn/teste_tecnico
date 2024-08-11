class Produtos2 {
  final bool hasDiscount;
  final String name;
  final List<dynamic> gallery;
  final String description;
  final String price;
  final String discountValue;
  final String adjective;
  final String material;
  final String id;

  Produtos2(
    this.hasDiscount,
    this.name,
    this.gallery,
    this.description,
    this.price,
    this.discountValue,
    this.adjective,
    this.material,
    this.id,
  );

  factory Produtos2.fromJson(dynamic data) {
    return Produtos2(
      data['hasDiscount'] as bool,
      data['name'] as String,
      data['gallery'] as List<dynamic>,
      data['description'] as String,
      data['price'] as String,
      data['discountValue'] as String,
      data['details']['adjective'] as String,
      data['details']['material'] as String,
      data['id'] as String
    );
  }
}
