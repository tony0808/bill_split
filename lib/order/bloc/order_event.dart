part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {
  const OrderEvent();
}

class OrderAddItemEvent extends OrderEvent {
  final Item item;

  const OrderAddItemEvent(this.item);
}

class OrderEditItemEvent extends OrderEvent {
  final int index;
  final Item item;
  const OrderEditItemEvent(this.index, this.item);
}

class OrderDeleteItemEvent extends OrderEvent {
  final int index;

  const OrderDeleteItemEvent(this.index);
}
