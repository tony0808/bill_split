import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Splitit',
            style: GoogleFonts.rowdies(color: Colors.white, fontSize: 48),
          ),
          backgroundColor: Theme.of(context).primaryColor,
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
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
