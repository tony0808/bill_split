import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final Map<String, double> data;

  const SummaryPage({super.key, required this.data});

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
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Summary'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      body: Column(
          children: data.entries.map((entry) {
        return _DebtData(name: entry.key, debt: entry.value);
      }).toList()),
    );
  }
}

class _DebtData extends StatelessWidget {
  final String name;
  final double debt;

  const _DebtData({required this.name, required this.debt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Material(
        elevation: 10,
        child: ListTile(
          title: Text(name, style: const TextStyle(fontSize: 20)),
          trailing: Text('\$ $debt', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 215, 215, 215),
            ),
          ),
        ),
      ),
    );
  }
}
