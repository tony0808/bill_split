import 'package:bill_split/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
      switch(state.status) {
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
    // TODO: implement build
    throw UnimplementedError();
  }
}

class DashboardOrderCreated extends StatelessWidget {
  const DashboardOrderCreated({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
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
