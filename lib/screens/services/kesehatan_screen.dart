import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class KesehatanScreen extends StatelessWidget {
  const KesehatanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kesehatan', style: TextStyle(color: kTextColor)),
        backgroundColor: kPrimaryColor.withAlpha(20),
      ),
      body: Center(
        child: Text(
          'Kesehatan Page',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
        ),
      ),
    );
  }
}