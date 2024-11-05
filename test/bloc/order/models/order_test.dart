import 'package:bill_split/order/models/item.dart';
import 'package:bill_split/order/models/order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('get item names', () {
    List<Item> items = [
      const Item(price: 20, name: 'item0', quantity: 1),
      const Item(price: 20, name: 'item1', quantity: 1),
      const Item(price: 20, name: 'item2', quantity: 1),
      const Item(price: 20, name: 'item3', quantity: 1),
      const Item(price: 20, name: 'item4', quantity: 1),
    ];
    
    Order order = Order(items: items, total: 0.0);

    List<String> names = order.getItemNames();

    expect('item0', names[0]);
    expect('item1', names[1]);
    expect('item2', names[2]);
    expect('item3', names[3]);
    expect('item4', names[4]);
  });
}
