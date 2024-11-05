import 'package:bill_split/home.dart';
import 'package:flutter/material.dart';

void main() {
  const primaryColor = Color.fromARGB(255, 141, 26, 176);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: const Home(),
    ),
  );
}
