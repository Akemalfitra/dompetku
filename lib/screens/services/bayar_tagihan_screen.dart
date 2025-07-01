// lib/screens/services/bayar_tagihan_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class BayarTagihanScreen extends StatelessWidget {
  const BayarTagihanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bills = [
      {'name': 'PLN', 'icon': Icons.flash_on_outlined, 'route': '/electric_bill'},
      {'name': 'PDAM', 'icon': Icons.water_drop_outlined, 'route': null},
      {'name': 'BPJS', 'icon': Icons.health_and_safety_outlined, 'route': null},
      {'name': 'Internet & TV', 'icon': Icons.router_outlined, 'route': '/internet'},
      {'name': 'Telepon Pascabayar', 'icon': Icons.phone_in_talk_outlined, 'route': null},
      {'name': 'Angsuran Kredit', 'icon': Icons.payments_outlined, 'route': null},
      {'name': 'Pajak', 'icon': Icons.account_balance_outlined, 'route': null},
      {'name': 'Lainnya', 'icon': Icons.more_horiz_outlined, 'route': null},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Bayar Tagihan', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.shade200,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: bills.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final bill = bills[index];
          return GestureDetector(
            onTap: () {
              if (bill['route'] != null) {
                Navigator.pushNamed(context, bill['route'] as String);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: kPrimaryColor.withAlpha(20),
                  child: Icon(bill['icon'] as IconData, color: kPrimaryColor, size: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  bill['name'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
