import 'package:bill_split/order/models/item.dart';

class Order {
  final double total;
  final List<Item> items;

  const Order({required this.total, required this.items});

  static const empty = Order(total: 0.0, items: []);

  List<String> getItemNames() {
    return items.map((item) => item.name).toList();
  }
}