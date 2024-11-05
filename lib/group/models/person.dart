


class Person {
  final String name;
  final List<AssignedItem> assignedItems;
  final bool isAssigned;

  const Person({required this.name, required this.assignedItems, required this.isAssigned});

  static const empty = Person(name: '-', assignedItems: [], isAssigned: false);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Person && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class AssignedItem {
}