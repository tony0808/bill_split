

class Item {
  final double price;
  final String name;
  final int quantity;

  const Item({required this.price, required this.name, required this.quantity});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Item && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}