import 'package:bill_split/group/bloc/group_bloc.dart';
import 'package:bill_split/group/models/person.dart';
import 'package:bill_split/assignmnet/view/assigned_items_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
      return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 40,
        ),
        padding: const EdgeInsets.all(20),
        itemBuilder: (BuildContext context, index) {
          return _PersonTile(
            person: state.group.people[index],
            index: index,
          );
        },
        itemCount: state.group.people.length,
      );
    });
  }
}

class _PersonTile extends StatelessWidget {
  final Person person;
  final int index;

  const _PersonTile({required this.person, required this.index});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: ListTile(
        title: _PersonTitle(
          name: person.name,
        ),
        subtitle: _PersonSubtitile(
          person: person,
          index: index,
          isAssigned: person.isAssigned,
        ),
        trailing: IconButton(
          onPressed: () {
            context.read<GroupBloc>().add(GroupDeletePersonEvent(index));
          },
          icon: const Icon(Icons.cancel),
        ),
        isThreeLine: true,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromARGB(255, 215, 215, 215),
          ),
        ),
      ),
    );
  }
}

class _PersonTitle extends StatelessWidget {
  final String name;

  const _PersonTitle({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class _PersonSubtitile extends StatelessWidget {
  final Person person;
  final int index;
  final bool isAssigned;

  const _PersonSubtitile({required this.isAssigned, required this.index, required this.person});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isAssigned ? 'Assigned' : 'Unassigned',
          style: const TextStyle(
            color: Color.fromARGB(255, 178, 178, 178),
            fontStyle: FontStyle.italic,
          ),
        ),
        Container(
          //decoration: BoxDecoration(border: Border.all()),
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.5 - 88.5),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return AssignedItemsPage(person: person, index: index,);
              }));
            },
            child: const Text(
              'Assign',
              style: TextStyle(fontSize: 20),
            ),
          ),
        )
      ],
    );
  }
}
