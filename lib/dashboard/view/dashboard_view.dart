import 'package:bill_split/dashboard/bloc/dashboard_bloc.dart';
import 'package:bill_split/dashboard/view/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const DashboardView());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DashboardBloc(),
      child: const DashboardPage(),
    );
  }
}
