// lib/screens/settings/quick_payment_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class QuickPaymentScreen extends StatefulWidget {
  const QuickPaymentScreen({super.key});

  @override
  State<QuickPaymentScreen> createState() => _QuickPaymentScreenState();
}

class _QuickPaymentScreenState extends State<QuickPaymentScreen> {
  bool _isQuickPaymentEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Pembayaran Cepat", style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SwitchListTile(
              title: const Text("Aktifkan Pembayaran Cepat", style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(
                "Bayar tanpa otentikasi untuk transaksi di bawah Rp 50.000.",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              value: _isQuickPaymentEnabled,
              onChanged: (value) {
                setState(() => _isQuickPaymentEnabled = value);
              },
              activeColor: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
