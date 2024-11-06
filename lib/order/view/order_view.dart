import 'package:bill_split/order/bloc/order_bloc.dart';
import 'package:bill_split/order/view/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const OrderView());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OrderBloc(),
      child: const OrderPage(),
    );
  }
}
