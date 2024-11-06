import 'package:bill_split/dashboard/view/dashboard_page.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: const Text(
            'Splitit',
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 600,
          ),
          Center(
            child: SizedBox(
              width: 390,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(DashboardPage.route());
                },
                child: const Text(
                  'Create Bill',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
