

import 'package:bill_split/group/models/person.dart';

class Group {
  final List<Person> people;

  const Group({required this.people});

  static const empty = Group(people: []);
}