import 'package:bill_split/group/bloc/group_bloc.dart';
import 'package:bill_split/assignmnet/models/assigned_item.dart';
import 'package:bill_split/group/models/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignedItemsList extends StatelessWidget {
  final Person person;

  const AssignedItemsList({super.key, required this.person});

  void deleteAssignedItem(BuildContext context, int index) {
    person.assignedItems.removeAt(index);

    Person newPerson = Person(
      name: person.name,
      assignedItems: person.assignedItems,
      isAssigned: person.assignedItems.isNotEmpty,
    );

    int personIndex = context.read<GroupBloc>().state.group.people.indexOf(person);

    context.read<GroupBloc>().add(GroupAssignItemEvent(personIndex, newPerson));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
      return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 40,
        ),
        padding: const EdgeInsets.all(20),
        itemBuilder: (BuildContext context, index) {
          return _AssignedItemTile(
            assignedItem: person.assignedItems[index],
            onDelete: () => deleteAssignedItem(context, index),
          );
        },
        itemCount: person.assignedItems.length,
      );
    });
  }
}

class _AssignedItemTile extends StatelessWidget {
  final AssignedItem assignedItem;
  final VoidCallback onDelete;

  const _AssignedItemTile({required this.assignedItem, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: ListTile(
        title: _AssignedItemTitle(
          title: assignedItem.item.name,
          quantity: assignedItem.quantity,
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.cancel),
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromARGB(255, 215, 215, 215),
          ),
        ),
      ),
    );
  }
}

class _AssignedItemTitle extends StatelessWidget {
  final String title;
  final int quantity;

  const _AssignedItemTitle({required this.title, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(width: 5),
        Text('x$quantity', style: const TextStyle(color: Color.fromARGB(255, 126, 126, 126), fontSize: 18)),
      ],
    );
  }
}
