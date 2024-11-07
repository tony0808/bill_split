import 'package:bill_split/group/bloc/group_bloc.dart';
import 'package:bill_split/assignmnet/models/assigned_item.dart';
import 'package:bill_split/group/models/group.dart';
import 'package:bill_split/group/models/person.dart';
import 'package:bill_split/order/models/item.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test group', () {
    late GroupBloc groupBloc;

    setUp(() {
      groupBloc = GroupBloc();
    });

    group('test add person', () {
      blocTest<GroupBloc, GroupState>(
        'emits [GroupStatus.add] when adding to empty group',
        build: () => groupBloc,
        act: (bloc) => bloc.add(const GroupAddPersonEvent(Person(name: 'Tony', assignedItems: [], isAssigned: false))),
        expect: () => [
          isA<GroupState>().having((state) => state.status, 'status', GroupStatus.added),
        ],
      );

      blocTest<GroupBloc, GroupState>(
        'emits [GroupStatus.add] when adding to non-empty group',
        build: () => groupBloc,
        seed: () => const GroupState(
          group: Group(
            people: [
              Person(name: 'John Cena', assignedItems: [], isAssigned: false),
            ],
          ),
        ),
        act: (bloc) => bloc.add(const GroupAddPersonEvent(Person(name: 'Tony', assignedItems: [], isAssigned: false))),
        expect: () => [
          isA<GroupState>()
              .having((state) => state.status, 'status', GroupStatus.added)
              .having((state) => state.group.people.length, 'group length', 2),
        ],
      );

      blocTest<GroupBloc, GroupState>(
        'emits [GroupStatus.error]',
        build: () => groupBloc,
        seed: () => const GroupState(
          group: Group(
            people: [
              Person(name: 'John Cena', assignedItems: [], isAssigned: false),
            ],
          ),
        ),
        act: (bloc) =>
            bloc.add(const GroupAddPersonEvent(Person(name: 'John Cena', assignedItems: [], isAssigned: false))),
        expect: () => [isA<GroupState>().having((state) => state.status, 'status', GroupStatus.error)],
      );
    });

    group('test delete person', () {
      blocTest<GroupBloc, GroupState>(
        'emit [GroupStatus.deleted]',
        build: () => groupBloc,
        seed: () => const GroupState(
          group: Group(
            people: [
              Person(name: 'John Cena 1', assignedItems: [], isAssigned: false),
              Person(name: 'John Cena 2', assignedItems: [], isAssigned: false),
              Person(name: 'John Cena 3', assignedItems: [], isAssigned: false),
              Person(name: 'John Cena 4', assignedItems: [], isAssigned: false),
            ],
          ),
        ),
        act: (bloc) => bloc.add(const GroupDeletePersonEvent(2)),
        expect: () => [
          isA<GroupState>()
              .having((state) => state.status, 'status', GroupStatus.deleted)
              .having((state) => state.group.people.length, 'group length', 3),
        ],
      );
    });

    group('test assign item', () {
      late List<AssignedItem> newItems;

      blocTest<GroupBloc, GroupState>(
        'emit [GroupStatus.assigned]',
        setUp: () => newItems = [const AssignedItem(item: Item(name: 'beer', price: 5.5, quantity: 2), quantity: 2)],
        build: () => groupBloc,
        seed: () => const GroupState(
          group: Group(
            people: [
              Person(name: 'John Cena 1', assignedItems: [], isAssigned: false),
              Person(name: 'John Cena 2', assignedItems: [], isAssigned: false),
              Person(name: 'John Cena 3', assignedItems: [], isAssigned: false),
              Person(name: 'John Cena 4', assignedItems: [], isAssigned: false),
            ],
          ),
        ),
        act: (bloc) => bloc.add(GroupAssignItemEvent(2, Person(name: 'John Cena 3', assignedItems: newItems, isAssigned: true))),
        expect: () => [
          isA<GroupState>()
              .having((state) => state.status, 'status', GroupStatus.assigned)
              .having((state) => state.group.people[2].assignedItems.first.item.name, 'assigned item', 'beer'),
        ],
      );
    });
  });
}
