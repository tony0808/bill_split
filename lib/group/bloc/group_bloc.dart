import 'package:bill_split/group/models/group.dart';
import 'package:bill_split/group/models/person.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(const GroupState()) {
    on<GroupAddPersonEvent>(_onAddPerson);
    on<GroupDeletePersonEvent>(_onDeletePerson);
    on<GroupAssignItemEvent>(_onAssignItem);
  }

  void _onAddPerson(GroupAddPersonEvent event, Emitter<GroupState> emit) {
    final currentGroup = state.group;
    final currentPeople = currentGroup.people;

    bool nameExists = currentPeople.any((person) => person.name == event.person.name);

    if (nameExists) {
      emit(state.copyWith(status: GroupStatus.error, errorMessage: 'Person already exists.'));
      return;
    }

    final List<Person> newPeople = [...currentPeople, event.person];
    final newGroup = Group(people: newPeople);

    emit(state.copyWith(group: newGroup, status: GroupStatus.added));
  }

  void _onDeletePerson(GroupDeletePersonEvent event, Emitter<GroupState> emit) {
    final currentGroup = state.group;
    final currentPeople = currentGroup.people;

    List<Person> newPeople = [...currentPeople];
    newPeople.removeAt(event.index);

    final newGroup = Group(people: newPeople);

    emit(state.copyWith(group: newGroup, status: GroupStatus.deleted));
  }

  void _onAssignItem(GroupAssignItemEvent event, Emitter<GroupState> emit) {
    
    final group = state.group;
    final people = group.people;

    List<Person> newPeople = [...people];
    newPeople.removeAt(event.index);
    newPeople.insert(event.index, event.person);

    final newGroup = Group(people: newPeople);
    
    emit(state.copyWith(group: newGroup, status: GroupStatus.assigned));
  }
}
