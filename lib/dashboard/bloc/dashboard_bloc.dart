import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<DashboardOrderCompletedEvent>(_onOrderCompleted);
    on<DashboardGroupCompletedEvent>(_onGroupCompleted);
  }

  void _onOrderCompleted(DashboardOrderCompletedEvent event, Emitter<DashboardState> emit) {
    emit(state.copyWith(status: DashboardStatus.orderCreated));
  }

  void _onGroupCompleted(DashboardGroupCompletedEvent event, Emitter<DashboardState> emit) {
    emit(state.copyWith(status: DashboardStatus.groupCreated));
  }
}
