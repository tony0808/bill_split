import 'package:bill_split/group/models/person.dart';
import 'package:bill_split/assignmnet/view/assigned_item_form.dart';
import 'package:bill_split/assignmnet/view/assigned_items_list.dart';
import 'package:flutter/material.dart';

class AssignedItemsPage extends StatelessWidget {
  final Person person;
  final int index;

  const AssignedItemsPage({super.key, required this.person, required this.index});

  void openBottomModalSheetForItemAddition(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => AssignedItemForm(person: person, index: index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(
                onPressed: () {
                  openBottomModalSheetForItemAddition(context);
                },
                icon: const Icon(
                  Icons.add,
                  size: 35,
                ),
              ),
            )
          ],
          title: Text(
            person.name,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      body: AssignedItemsList(
        person: person,
      ),
    );
  }
}
