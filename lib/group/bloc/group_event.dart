part of 'group_bloc.dart';

@immutable
sealed class GroupEvent {
  const GroupEvent();
}

class GroupAddPersonEvent extends GroupEvent {
  final Person person;

  const GroupAddPersonEvent(this.person);
}

class GroupDeletePersonEvent extends GroupEvent {
  final int index;

  const GroupDeletePersonEvent(this.index);
}

class GroupAssignItemEvent extends GroupEvent {
  final Person person;
  final int index;

  const GroupAssignItemEvent(this.index, this.person);
}