import 'package:bill_split/dashboard/bloc/dashboard_bloc.dart';
import 'package:bill_split/order/view/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const DashboardPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
      switch (state.status) {
        case DashboardStatus.initial:
          return const DashboardInitial();
        case DashboardStatus.orderCreated:
          return const DashboardOrderCreated();
        case DashboardStatus.groupCreated:
          return const DashboardGroupCreated();
      }
    });
  }
}

class DashboardInitial extends StatelessWidget {
  const DashboardInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: const Text(
            'Dashboard',
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CustomElevatedButton(
                width: 177,
                height: 56,
                fontSize: 32,
                title: 'Order',
                isVerified: false,
                onPressed: () {
                  Navigator.of(context).push(OrderPage.route());
                },
              ),
              const SizedBox(width: 10),
              const _CustomElevatedButton(
                width: 177,
                height: 56,
                fontSize: 32,
                title: 'Group',
                isVerified: false,
                onPressed: null,
              ),
            ],
          ),
          const SizedBox(height: 40),
          const _CustomElevatedButton(
            width: 365,
            height: 76,
            fontSize: 32,
            title: 'Calculate',
            isVerified: false,
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class _CustomElevatedButton extends StatelessWidget {
  final String title;
  final double width, height, fontSize;
  final void Function()? onPressed;
  final bool isVerified;

  const _CustomElevatedButton({
    required this.title,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.onPressed,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: isVerified ? const BorderSide(color: Color.fromARGB(255, 113, 222, 255), width: 4) : BorderSide.none,
          disabledBackgroundColor: Theme.of(context).primaryColor,
          disabledForegroundColor: const Color.fromARGB(110, 255, 255, 255),
        ),
        child: Text(title, style: TextStyle(fontSize: fontSize)),
      ),
    );
  }
}

class DashboardOrderCreated extends StatelessWidget {
  const DashboardOrderCreated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: const Text(
            'Dashboard',
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CustomElevatedButton(
                width: 177,
                height: 56,
                fontSize: 32,
                title: 'Order',
                isVerified: true,
                onPressed: () {
                  Navigator.of(context).push(OrderPage.route());
                },
              ),
              const SizedBox(width: 10),
              _CustomElevatedButton(
                width: 177,
                height: 56,
                fontSize: 32,
                title: 'Group',
                isVerified: false,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 40),
          const _CustomElevatedButton(
            width: 365,
            height: 76,
            fontSize: 32,
            isVerified: false,
            title: 'Calculate',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class DashboardGroupCreated extends StatelessWidget {
  const DashboardGroupCreated({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
