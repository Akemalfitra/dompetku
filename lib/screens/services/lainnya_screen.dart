import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lainnya', style: TextStyle(color: kTextColor)),
        backgroundColor: kPrimaryColor.withAlpha(20),
      ),
      body: Center(
        child: Text(
          'Lainnya Page',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
        ),
      ),
    );
  }
}