part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {
  const DashboardEvent();
}

class DashboardOrderCompletedEvent extends DashboardEvent {}

class DashboardGroupCompletedEvent extends DashboardEvent {
  final List<Item> foodItems;
  final List<Person> people;

  const DashboardGroupCompletedEvent(this.foodItems, this.people);
}

class DashboardResetEvent extends DashboardEvent {}