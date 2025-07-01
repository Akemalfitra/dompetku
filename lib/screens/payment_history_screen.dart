import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  static final List<Map<String, String>> _history = [
    {'provider': 'Maya power', 'details': '32289HF - 4378', 'date': 'April 26, 2016', 'amount': '\$45,6'},
    {'provider': 'Time power', 'details': '...', 'date': 'December 2, 2018', 'amount': '\$36.84'},
    {'provider': 'Obien power', 'details': '...', 'date': 'February 28, 2012', 'amount': '\$16.43'},
    {'provider': 'Maya power', 'details': '...', 'date': 'September 9, 2013', 'amount': '\$27.43'},
    {'provider': 'Maya power', 'details': '...', 'date': 'July 14, 2015', 'amount': '\$49.98'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pembayaran', style: TextStyle(color: kTextColor)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _history.length,
        itemBuilder: (context, index) {
          final item = _history[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.flash_on)),
            title: Text(item['provider']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${item['details']!}\n${item['date']!}'),
            trailing: Text(item['amount']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            isThreeLine: true,
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}