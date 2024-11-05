part of 'order_bloc.dart';

enum OrderStatus { initial, added, edited, deleted, error }

class OrderState {
  final Order order;
  final OrderStatus status;
  final String? errorMessage;

  OrderState({this.status = OrderStatus.initial, this.order = Order.empty, this.errorMessage});

  OrderState copyWith({
    Order? order,
    OrderStatus? status,
    String? errorMessage,
  }) {
    return OrderState(
      order: order ?? this.order,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
