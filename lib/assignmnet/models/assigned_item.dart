import 'package:bill_split/order/models/item.dart';

class AssignedItem {
  final Item item;
  final int quantity;

  const AssignedItem({required this.item, required this.quantity});
}