import 'package:bill_split/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const OrderPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 35,),
              ),
            )
          ],
          title: const Text(
            'Order',
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
     
    );
  }
}
