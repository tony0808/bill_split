part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, orderCreated, groupCreated }

class DashboardState {
  final DashboardStatus status;
  final SummaryData summaryData;

  const DashboardState({this.status = DashboardStatus.initial, this.summaryData = SummaryData.empty});

  DashboardState copyWith({
    DashboardStatus? status,
    SummaryData? summaryData,
  }) {
    return DashboardState(
      summaryData: summaryData ?? this.summaryData,
      status: status ?? this.status,
    );
  }
}
