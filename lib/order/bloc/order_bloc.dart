import 'package:bill_split/order/models/item.dart';
import 'package:bill_split/order/models/order.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState()) {
    on<OrderAddItemEvent>(_onAddItem);
    on<OrderEditItemEvent>(_onEditItem);
    on<OrderDeleteItemEvent>(_onDeleteItem);
  }

  void _onAddItem(OrderAddItemEvent event, Emitter<OrderState> emit) {
    final currentOrder = state.order;
    final currentItems = currentOrder.items;

    final List<Item> newItems = [...currentItems, event.item];
    final newTotal = currentOrder.total + event.item.price * event.item.quantity;

    final newOrder = Order(items: newItems, total: newTotal);

    emit(state.copyWith(order: newOrder, status: OrderStatus.added));
  }

  void _onEditItem(OrderEditItemEvent event, Emitter<OrderState> emit) {
    final currentOrder = state.order;
    final currentItems = currentOrder.items;


    double newTotal = currentOrder.total;

    List<Item> newItems = [...currentItems];
    Item itemToEdit = newItems.elementAt(event.index);
    newTotal -= itemToEdit.price * itemToEdit.quantity;
    newItems.removeAt(event.index);
    newItems.insert(event.index, event.item);
    newTotal += event.item.price * event.item.quantity;
   
    final newOrder = Order(total: newTotal, items: newItems);

    emit(state.copyWith(order: newOrder, status: OrderStatus.edited));
  }

  void _onDeleteItem(OrderDeleteItemEvent event, Emitter<OrderState> emit) {
    final currentOrder = state.order;
    final currentItems = currentOrder.items;

    double newTotal = currentOrder.total;

    List<Item> newItems = [...currentItems];
    Item itemToDelete = newItems.elementAt(event.index);
    newTotal -= itemToDelete.price * itemToDelete.quantity;
    newItems.removeAt(event.index); 
    
    final order = Order(total: newTotal, items: newItems);

    emit(state.copyWith(order: order, status: OrderStatus.deleted));
  }
}
