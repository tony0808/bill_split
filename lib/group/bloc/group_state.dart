part of 'group_bloc.dart';

enum GroupStatus { initial, added, deleted, error }

class GroupState {
  final Group group;
  final GroupStatus status;
  final String? errorMessage;

  const GroupState({this.group = Group.empty, this.status = GroupStatus.initial, this.errorMessage});

  GroupState copyWith({
    Group? group,
    GroupStatus? status,
    String? errorMessage,
  }) {
    return GroupState(
      errorMessage: errorMessage ?? this.errorMessage,
      group: group ?? this.group,
      status: status ?? this.status,
    );
  }
}
