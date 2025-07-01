import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class BelanjaScreen extends StatelessWidget {
  const BelanjaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belanja', style: TextStyle(color: kTextColor)),
        backgroundColor: kPrimaryColor.withAlpha(20),
      ),
      body: const Center(
        child: Text(
          'Belanja Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
        ),
      ),
    );
  }
} 