import 'package:bill_split/group/bloc/group_bloc.dart';
import 'package:bill_split/assignmnet/models/assigned_item.dart';
import 'package:bill_split/group/models/person.dart';
import 'package:bill_split/order/bloc/order_bloc.dart';
import 'package:bill_split/order/models/item.dart';
import 'package:bill_split/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignedItemForm extends StatefulWidget {
  final Person person;
  final int index;

  const AssignedItemForm({super.key, required this.person, required this.index});

  @override
  State<AssignedItemForm> createState() => _AssignedItemFormState();
}

class _AssignedItemFormState extends State<AssignedItemForm> {
  final _menuController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void dispose() {
    _menuController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void createAssignedItem(BuildContext context, int index, Person person) {
    if (areValuesEmpty()) {
      return;
    }

    final foodItems = context.read<OrderBloc>().state.order.items;
    final selectedFoodItem = _menuController.text;

    final foodItem = foodItems.firstWhere((item) => item.name == selectedFoodItem);
    final quantity = int.parse(_quantityController.text);

    AssignedItem assignedItem = AssignedItem(item: foodItem, quantity: quantity);
    widget.person.assignedItems.add(assignedItem);

    final newPerson = Person(
      name: person.name,
      assignedItems: widget.person.assignedItems,
      isAssigned: true,
    );

    context.read<GroupBloc>().add(GroupAssignItemEvent(index, newPerson));

    Navigator.of(context).pop();
  }

  bool areValuesEmpty() {
    return _menuController.text.isEmpty || _quantityController.text.isEmpty;
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
          _FoodItemSelection(
            controller: _menuController,
            person: widget.person,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: _quantityController,
            hintText: 'Enter quantity',
            type: TextInputType.number,
          ),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    createAssignedItem(context, widget.index, widget.person);
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

class _FoodItemSelection extends StatelessWidget {
  final TextEditingController controller;
  final Person person;

  const _FoodItemSelection({required this.controller, required this.person});

  @override
  Widget build(BuildContext context) {
    final foodItems = context.read<OrderBloc>().state.order.items;
    final assignedItems = person.assignedItems;

    final unassignedItems = foodItems.where((foodItem) {
      return !assignedItems.any((assignedItem) => assignedItem.item == foodItem);
    }).toList();

    return Container(
      // decoration: BoxDecoration(border: Border.all()),
      margin: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: DropdownMenu<Item>(
          controller: controller,
          hintText: 'Select Food Item',
          width: MediaQuery.of(context).size.width - 40,
          dropdownMenuEntries: unassignedItems.map<DropdownMenuEntry<Item>>((Item item) {
            return DropdownMenuEntry<Item>(value: item, label: item.name);
          }).toList(),
        ),
      ),
    );
  }
}
