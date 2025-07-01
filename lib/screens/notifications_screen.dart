import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifikasi (23)", style: TextStyle(color: kTextColor)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNotificationTile(
            icon: Icons.arrow_downward,
            color: Colors.green,
            title: "Terima Uang",
            timestamp: "1/7/2021 15:00",
            amount: "+ \$1850",
            message: "dari Lena Nguyen. Pesan: \"Transfer biasa\""
          ),
          const Divider(),
          _buildNotificationTile(
            icon: Icons.receipt_long,
            color: kPrimaryColor,
            title: "Hasil Transaksi",
            timestamp: "1/7/2021 15:00",
            message: "Anda telah berhasil melakukan pembayaran sebesar \$45 untuk Andy. Nomor referensi: 81292840. Kontak dukungan: 9000322583."
          ),
           const Divider(),
          _buildNotificationTile(
            icon: Icons.arrow_downward,
            color: Colors.green,
            title: "Terima Uang",
            timestamp: "1/7/2021 15:00",
            amount: "+ \$1",
            message: "dari Andy Kros. Pesan: \"Terima kasih!\""
          ),
        ],
      ),
    );
  }
    Widget _buildNotificationTile({
    required IconData icon,
    required Color color,
    required String title,
    required String timestamp,
    required String message,
    String? amount,
  }) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color.withAlpha(30), child: Icon(icon, color: color)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(timestamp, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(message),
        ],
      ),
      trailing: amount != null ? Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)) : null,
      isThreeLine: true,
      contentPadding: EdgeInsets.zero,
    );
  }
}