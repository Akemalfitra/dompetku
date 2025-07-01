import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Isi Saldo", style: TextStyle(color: kTextColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 32,
                backgroundColor: kPrimaryColor,
                child: Icon(Icons.arrow_downward, color: Colors.white, size: 32),
              ),
            ),
            const SizedBox(height: 8),
            const Center(child: Text("Isi saldo dompet", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            const SizedBox(height: 32),
            const Text("Jumlah", style: TextStyle(color: Colors.grey)),
            const TextField(
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: "\$",
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 24),
            const Text("Dari", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.credit_card, color: kPrimaryColor),
              title: const Text("Visa"),
              subtitle: const Text("**** 3453"),
              trailing: const Icon(Icons.check_circle, color: kPrimaryColor),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12)
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: (){ Navigator.of(context).pop(); },
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text("Lanjutkan"),
            ),
          ],
        ),
      ),
    );
  }
}