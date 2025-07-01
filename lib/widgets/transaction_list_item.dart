import 'package:flutter/material.dart';
import 'package:dompetku/main.dart'; // Pastikan path ini benar untuk kTextColor

class TransactionListItem extends StatelessWidget {
  final String title;
  final String date;
  final double amount;
  final IconData icon;
  final Color? iconColor; // Parameter opsional untuk warna ikon

  const TransactionListItem({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.icon,
    this.iconColor, // Tambahkan di constructor
  });

  @override
  Widget build(BuildContext context) {
    // Tentukan warna default berdasarkan jumlah (jika iconColor tidak disediakan)
    final defaultColor = amount >= 0 ? Colors.green.shade600 : Colors.red.shade600;
    final color = iconColor ?? defaultColor;

    // Format string jumlah agar selalu memiliki 2 angka desimal
    final amountString = amount >= 0
        ? '+ \$${amount.abs().toStringAsFixed(2)}'
        : '- \$${amount.abs().toStringAsFixed(2)}';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: color.withAlpha(30), // Latar belakang lebih soft
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600, // Sedikit lebih tipis dari bold
          color: kTextColor,
          fontSize: 15,
        ),
      ),
      // Tampilkan subtitle hanya jika 'date' tidak kosong
      subtitle: date.isNotEmpty
          ? Text(
              date,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            )
          : null,
      trailing: Text(
        amountString,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }
}