import 'package:bill_split/group/bloc/group_bloc.dart';
import 'package:bill_split/group/models/person.dart';
import 'package:bill_split/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonForm extends StatefulWidget {
  const PersonForm({super.key});

  @override
  State<PersonForm> createState() => _PersonFormState();
}

class _PersonFormState extends State<PersonForm> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void addPersonToGroup() {
    final fullname = _nameController.text;

    Person person = Person(
      name: fullname,
      assignedItems: [],
      isAssigned: false,
    );

    context.read<GroupBloc>().add(GroupAddPersonEvent(person));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          CustomTextField(
            controller: _nameController,
            hintText: 'Enter full name',
            type: TextInputType.text,
          ),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    addPersonToGroup();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Create'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
