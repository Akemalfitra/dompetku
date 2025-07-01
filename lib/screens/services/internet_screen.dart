import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class InternetScreen extends StatelessWidget {
  const InternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet', style: TextStyle(color: kTextColor)),
        backgroundColor: kPrimaryColor.withAlpha(20),
      ),
      body: Center(
        child: Text(
          'Internet Page',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
        ),
      ),
    );
  }
}   