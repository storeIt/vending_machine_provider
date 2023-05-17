class Category {
  final String? name;
  final double? price;

  Category({this.name, this.price});

  Category copyWith({String? name, double? price}) {
    return Category(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}
