// lib/screens/confirm_transfer_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';
import 'package:lottie/lottie.dart'; // Pastikan Anda sudah menambahkan package lottie

class ConfirmTransferScreen extends StatefulWidget {
  const ConfirmTransferScreen({super.key});

  @override
  State<ConfirmTransferScreen> createState() => _ConfirmTransferScreenState();
}

class _ConfirmTransferScreenState extends State<ConfirmTransferScreen> {
  bool _isAuthenticated = false;

  void _showBiometricDialog() {
    // Simulasi otentikasi berhasil
    setState(() => _isAuthenticated = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Otentikasi berhasil!'),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/lottie/success.json', height: 120, repeat: false),
            const SizedBox(height: 16),
            const Text("Transfer Berhasil!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Anda berhasil mentransfer Rp 1.000.000 ke Amanda", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text("Selesai"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Konfirmasi Transfer', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 24),
          _buildAuthenticationSection(),
        ],
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Detail Transaksi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildInfoRow("Dari", "VISA **** 1234"),
          _buildInfoRow("Kepada", "Amanda (BCA)"),
          _buildInfoRow("Nomor Rekening", "0123 4567 89"),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _buildInfoRow("Jumlah Transfer", "Rp 1.000.000"),
          _buildInfoRow("Biaya Admin", "Rp 0"),
          const SizedBox(height: 12),
          const Divider(thickness: 1.5),
          const SizedBox(height: 12),
          _buildInfoRow("Total", "Rp 1.000.000", isAmount: true),
        ],
      ),
    );
  }

  Widget _buildAuthenticationSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          const Text("Otentikasi Keamanan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(
            _isAuthenticated
                ? "Otentikasi berhasil, silakan lanjutkan transaksi."
                : "Gunakan PIN atau biometrik untuk melanjutkan transaksi.",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          _isAuthenticated
              ? const Icon(Icons.check_circle_rounded, color: Colors.green, size: 50)
              : OutlinedButton.icon(
                  onPressed: _showBiometricDialog,
                  icon: const Icon(Icons.fingerprint),
                  label: const Text("Gunakan Biometrik/PIN"),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    foregroundColor: kPrimaryColor,
                    side: const BorderSide(color: kPrimaryColor),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isAmount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isAmount ? FontWeight.bold : FontWeight.w500,
              fontSize: isAmount ? 18 : 14,
              color: kTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: _isAuthenticated ? _showSuccessDialog : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isAuthenticated ? kPrimaryColor : Colors.grey.shade400,
          minimumSize: const Size(double.infinity, 55),
        ),
        child: const Text("Konfirmasi & Transfer", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
