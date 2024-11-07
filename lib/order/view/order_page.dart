import 'package:bill_split/dashboard/bloc/dashboard_bloc.dart';
import 'package:bill_split/group/bloc/group_bloc.dart';
import 'package:bill_split/group/models/person.dart';
import 'package:bill_split/order/bloc/order_bloc.dart';
import 'package:bill_split/order/widgets/food_item_form.dart';
import 'package:bill_split/order/widgets/order_list.dart';
import 'package:bill_split/order/widgets/total_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const OrderPage());
  }

  void openBottomModalSheetForItemAddition(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => const FoodItemForm(),
    );
  }

  void navigateBackToDashboard(BuildContext context) {
    final orderState = context.read<OrderBloc>().state;
    final groupState = context.read<GroupBloc>().state;
    final people = groupState.group.people;

    bool isGroupVerified = people.isNotEmpty;

    for (Person person in people) {
      if (!person.isAssigned) {
        isGroupVerified = false;
        break;
      }
    }

    if (isGroupVerified) {
      final foodItems = context.read<OrderBloc>().state.order.items;
      final people = context.read<GroupBloc>().state.group.people;
      context.read<DashboardBloc>().add(DashboardGroupCompletedEvent(foodItems, people));
    }
    else if (orderState.order.items.isNotEmpty) {
      context.read<DashboardBloc>().add(DashboardOrderCompletedEvent());
    } else {
      context.read<DashboardBloc>().add(DashboardResetEvent());
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navigateBackToDashboard(context);
            },
          ),
          actions: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(
                onPressed: () {
                  openBottomModalSheetForItemAddition(context);
                },
                icon: const Icon(
                  Icons.add,
                  size: 35,
                ),
              ),
            )
          ],
          title: const Text(
            'Order',
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      body: const Column(
        children: [
          TotalAmount(),
          Expanded(child: OrderList()),
        ],
      ),
    );
  }
}
