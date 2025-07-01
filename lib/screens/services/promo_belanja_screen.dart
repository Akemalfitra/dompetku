import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class PromoBelanjaScreen extends StatelessWidget {
  const PromoBelanjaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo Belanja', style: TextStyle(color: kTextColor)),
        backgroundColor: kPrimaryColor.withAlpha(20),
      ),
      body: Center(
        child: Text(
          'Promo Belanja Page',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
        ),
      ),
    );
  }
}