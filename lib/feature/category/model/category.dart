class Category {
  final String? name;
  final double? price;

  Category({this.name, this.price});

  @override
  String toString() {
    return 'Category{name: $name, price: $price}';
  }
}
