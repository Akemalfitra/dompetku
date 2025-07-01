import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  static const List<Map<String, dynamic>> _mostUsedServices = [
    {'icon': Icons.receipt_long, 'label': 'Bayar Tagihan', 'route': '/bayar_tagihan'},
    {'icon': Icons.phone_android, 'label': 'Isi Ulang', 'route': '/mobile_top_up'},
    {'icon': Icons.local_offer, 'label': 'Diskon', 'route': '/diskon'},
    {'icon': Icons.shopping_bag, 'label': 'Belanja', 'route': '/belanja'},
  ];

  static const List<Map<String, dynamic>> _allServices = [
    {'icon': Icons.shopping_bag_outlined, 'label': 'Promo Belanja', 'route': '/promo_belanja'},
    {'icon': Icons.swap_horiz, 'label': 'Transfer Bank', 'route': '/transfer'},
    {'icon': Icons.sports_soccer, 'label': 'Tiket Bola', 'route': '/tiket_bola'},
    {'icon': Icons.electric_bolt, 'label': 'Listrik', 'route': '/electric_bill'},
    {'icon': Icons.health_and_safety, 'label': 'Kesehatan', 'route': '/kesehatan'},
    {'icon': Icons.wifi, 'label': 'Internet', 'route': '/internet'},
    {'icon': Icons.local_offer_outlined, 'label': 'Diskon', 'route': '/diskon'},
    {'icon': Icons.music_note, 'label': 'Musik', 'route': '/musik'},
    {'icon': Icons.confirmation_number, 'label': 'Tiket', 'route': '/tiket'},
    {'icon': Icons.gamepad, 'label': 'Game', 'route': '/game'},
    {'icon': Icons.receipt_long_outlined, 'label': 'Tagihan', 'route': '/bayar_tagihan'},
    {'icon': Icons.more_horiz, 'label': 'Lainnya', 'route': '/lainnya'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layanan', style: TextStyle(color: kTextColor)),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.more_horiz)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildServiceSection(
            context,
            title: 'Paling Sering Digunakan',
            serviceList: _mostUsedServices,
          ),
          const SizedBox(height: 24),
          _buildServiceSection(
            context,
            title: 'Semua Layanan',
            serviceList: _allServices,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kPrimaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Layanan Baru', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                Text('Cari tempat terdekat yang menerima pembayaran QR dengan Camo-QR'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSection(BuildContext context, {required String title, required List<Map<String, dynamic>> serviceList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: serviceList.length,
          itemBuilder: (context, index) {
            final service = serviceList[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, service['route'] as String);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(service['icon'] as IconData, color: kPrimaryColor, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    service['label'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}