import 'package:bill_split/dashboard/bloc/dashboard_bloc.dart';
import 'package:bill_split/group/bloc/group_bloc.dart';
import 'package:bill_split/group/models/person.dart';
import 'package:bill_split/group/widgets/group_list.dart';
import 'package:bill_split/group/widgets/person_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const GroupPage());
  }

  void openBottomModalSheetForItemAddition(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => const PersonForm(),
    );
  }

  void navigateBackToDashboard(BuildContext context) {

    final people = context.read<GroupBloc>().state.group.people;
    bool isVerified = people.isNotEmpty;

    for(Person person in people) {
      if(!person.isAssigned) {
        isVerified = false;
        break;
      }
    }

    context.read<DashboardBloc>().add(isVerified ? DashboardGroupCompletedEvent() : DashboardOrderCompletedEvent());

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navigateBackToDashboard(context);
            },
          ),
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
          title: const Text(
            'Group',
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      body: const GroupList(),
    );
  }
}
