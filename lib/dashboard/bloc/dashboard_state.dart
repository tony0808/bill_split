part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, orderCreated, groupCreated }

class DashboardState {
  final DashboardStatus status;

  const DashboardState({this.status = DashboardStatus.initial});

  DashboardState copyWith({DashboardStatus? status}) {
    return DashboardState(
      status: status ?? this.status
    );
  }
}
