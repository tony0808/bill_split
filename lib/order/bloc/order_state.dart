part of 'order_bloc.dart';

enum OrderStatus { initial, added, edited, deleted }

class OrderState {
  final Order order;
  final OrderStatus status;

  OrderState({this.status = OrderStatus.initial, this.order = Order.empty});

  OrderState copyWith({
    Order? order,
    OrderStatus? status,
  }) {
    return OrderState(
      order: order ?? this.order,
      status: status ?? this.status,
    );
  }
}
