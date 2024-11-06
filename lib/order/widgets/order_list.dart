import 'package:bill_split/order/bloc/order_bloc.dart';
import 'package:bill_split/order/models/item.dart';
import 'package:bill_split/order/widgets/food_item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 40,
        ),
        itemCount: state.order.items.length,
        padding: const EdgeInsets.all(20),
        itemBuilder: (BuildContext context, index) {
          return _FoodItemTile(
            item: state.order.items[index],
            index: index,
          );
        },
      );
    });
  }
}

class _FoodItemTile extends StatelessWidget {
  final Item item;
  final int index;

  const _FoodItemTile({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: ListTile(
        title: _FoodItemTitle(item: item),
        subtitle: _FoodItemSubtitle(item: item),
        trailing: _FoodItemTrailing(item: item, index: index),
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromARGB(255, 215, 215, 215),
          ),
        ),
      ),
    );
  }
}

class _FoodItemTrailing extends StatelessWidget {
  final Item item;
  final int index;

  const _FoodItemTrailing({required this.item, required this.index});

  void openBottomModalSheetForItemEditing(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => FoodItemForm(
        isEdit: true,
        index: index,
        item: item,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () {
              openBottomModalSheetForItemEditing(context);
            },
            icon: const Icon(Icons.edit)),
        IconButton(
            onPressed: () {
              context.read<OrderBloc>().add(OrderDeleteItemEvent(index));
            },
            icon: const Icon(Icons.cancel_sharp)),
      ],
    );
  }
}

class _FoodItemSubtitle extends StatelessWidget {
  final Item item;

  const _FoodItemSubtitle({required this.item});

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$${item.price} x ${item.quantity} = \$ ${item.price * item.quantity}',
      style: const TextStyle(
        color: Color.fromARGB(255, 178, 178, 178),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}

class _FoodItemTitle extends StatelessWidget {
  final Item item;

  const _FoodItemTitle({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          item.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        Text(
          'x${item.quantity}',
          style: const TextStyle(color: Color.fromARGB(255, 126, 126, 126), fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}
