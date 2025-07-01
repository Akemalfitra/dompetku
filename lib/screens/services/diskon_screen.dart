import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class DiskonScreen extends StatelessWidget {
  const DiskonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diskon', style: TextStyle(color: kTextColor)),
        backgroundColor: kPrimaryColor.withAlpha(20),
      ),
      body: Center(
        child: Text(
          'Diskon Page',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
        ),
      ),
    );
  }
}