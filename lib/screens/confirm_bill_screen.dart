import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class ConfirmBillScreen extends StatefulWidget {
  const ConfirmBillScreen({super.key});

  @override
  State<ConfirmBillScreen> createState() => _ConfirmBillScreenState();
}

class _ConfirmBillScreenState extends State<ConfirmBillScreen> {
  int _selectedPaymentMethod = 1;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
          height: 380,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/signup.png', height: 120),
              const SizedBox(height: 20),
              const Text('Pembayaran Anda berhasil!', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('\$45,6', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: kPrimaryColor)),
              const Text('Dari saldo dompet', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                onPressed: () {
                  // Kembali ke halaman utama (tab) setelah semua proses selesai
                  Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                },
                child: const Text('Selesai'),
              ),
              TextButton(onPressed: (){}, child: const Text('Simpan Tagihan')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Tagihan', style: TextStyle(color: kTextColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Jumlah', style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 8),
            const Text('\$45,6', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.receipt_long, size: 40, color: kPrimaryColor),
              title: Text('32289HF-4378'),
              subtitle: Text('Maya power 2:29 PM 1/14/2022'),
            ),
            const Divider(),
            RadioListTile<int>(
              value: 1,
              groupValue: _selectedPaymentMethod,
              onChanged: (v) => setState(() => _selectedPaymentMethod = v!),
              title: const Text('Dari Dompet (saldo)'),
              subtitle: const Text('\$ 13 840'),
              activeColor: kPrimaryColor,
            ),
            RadioListTile<int>(
              value: 2,
              groupValue: _selectedPaymentMethod,
              onChanged: (v) => setState(() => _selectedPaymentMethod = v!),
              title: const Text('Dari Visa'),
              subtitle: const Text('**** 3453'),
              activeColor: kPrimaryColor,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: _showSuccessDialog,
          icon: const Icon(Icons.shield_outlined),
          label: const Text('Bayar'),
          style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
        ),
      ),
    );
  }
}