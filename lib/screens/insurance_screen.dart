// lib/screens/insurance_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Asuransi', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.shade200,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHeaderBanner(),
          const SizedBox(height: 24),
          _buildSectionTitle("Pilih Produk Asuransi"),
          const SizedBox(height: 16),
          _buildInsuranceGrid(),
          const SizedBox(height: 24),
          _buildSectionTitle("Partner Kami"),
          const SizedBox(height: 16),
          _buildPartnerLogos(),
        ],
      ),
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [kPrimaryColor, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Proteksi Maksimal",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Lindungi diri dan keluarga dengan premi terjangkau.",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Icon(Icons.shield, color: Colors.white.withOpacity(0.3), size: 60),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildInsuranceGrid() {
    final products = [
      {'name': 'Kesehatan', 'icon': Icons.local_hospital_outlined},
      {'name': 'Jiwa', 'icon': Icons.favorite_border},
      {'name': 'Kendaraan', 'icon': Icons.directions_car_outlined},
      {'name': 'Perjalanan', 'icon': Icons.flight_takeoff_outlined},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(product['icon'] as IconData, color: kPrimaryColor, size: 36),
              const Spacer(),
              Text(product['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPartnerLogos() {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: const Text(
        "Logo Partner (e.g., Allianz, Prudential, AXA)",
        style: TextStyle(color: Colors.grey),
      ), // Ganti dengan ListView logo
    );
  }
}
