part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardOrderCompletedEvent extends DashboardEvent {}

class DashboardGroupCompletedEvent extends DashboardEvent {}