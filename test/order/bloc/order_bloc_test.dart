import 'package:bill_split/order/bloc/order_bloc.dart';
import 'package:bill_split/order/models/item.dart';
import 'package:bill_split/order/models/order.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test order bloc', () {
    late OrderBloc orderBloc;

    setUp(() {
      orderBloc = OrderBloc();
    });

    group('test add item', () {
      blocTest<OrderBloc, OrderState>(
        'adds item in an empty list and emits [OrderStatus.added] with correct total',
        build: () => orderBloc,
        act: (bloc) => bloc.add(const OrderAddItemEvent(Item(price: 20.50, name: 'Sea Food', quantity: 2))),
        expect: () => [
          isA<OrderState>()
              .having((state) => state.status, 'status', OrderStatus.added)
              .having((state) => state.order.total, 'total', 20.50),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'adds item in an non-empty list and emits [OrderStatus.added] with correct total',
        build: () => orderBloc,
        seed: () => OrderState(
          order: const Order(items: [
            Item(price: 40.50, name: 'Sea Food', quantity: 1),
            Item(price: 50.50, name: 'Pasta', quantity: 1),
            Item(price: 5.00, name: 'Pasta', quantity: 3),
          ], total: 106.00),
        ),
        act: (bloc) => bloc.add(const OrderAddItemEvent(Item(price: 2.00, name: 'Sea Food', quantity: 5))),
        expect: () => [
          isA<OrderState>()
              .having((state) => state.status, 'status', OrderStatus.added)
              .having((state) => state.order.total, 'total', 116.00),
        ],
      );
    });

    group('test edit item', () {
      blocTest<OrderBloc, OrderState>('emit [OrderStatus.edited] with correct total',
          build: () => orderBloc,
          seed: () => OrderState(
                order: const Order(items: [
                  Item(price: 40.50, name: 'Sea Food', quantity: 1),
                  Item(price: 50.50, name: 'Pasta', quantity: 1),
                  Item(price: 5.00, name: 'Pasta', quantity: 3),
                ], total: 106.00),
              ),
          act: (bloc) => bloc.add(const OrderEditItemEvent(0, Item(name: 'Item', price: 49.50, quantity: 1))),
          expect: () => [
                isA<OrderState>()
                    .having((state) => state.order.total, 'total', 115.00)
                    .having((state) => state.status, 'status', OrderStatus.edited),
              ]);
    });

    group('test delete item', () {
      blocTest<OrderBloc, OrderState>('emit [OrderStatus.deleted] with correct total',
          build: () => orderBloc,
          seed: () => OrderState(
                order: const Order(items: [
                  Item(price: 40.50, name: 'Sea Food', quantity: 1),
                  Item(price: 50.50, name: 'Pasta', quantity: 1),
                  Item(price: 5.00, name: 'Pasta', quantity: 3),
                ], total: 106.00),
              ),
          act: (bloc) => bloc.add(const OrderDeleteItemEvent(0)),
          expect: () => [
                isA<OrderState>()
                    .having((state) => state.order.total, 'total', 65.50)
                    .having((state) => state.status, 'status', OrderStatus.deleted),
              ]);
    });
  });
}
