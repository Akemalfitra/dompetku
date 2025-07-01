// lib/screens/settings/app_info_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Informasi Aplikasi", style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', height: 80), // Ganti dengan path logo Anda
                const SizedBox(height: 16),
                const Text("Dompetku", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor)),
                const Text("Versi 1.0.0", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildInfoTile(
            icon: Icons.policy_outlined,
            title: "Kebijakan Privasi",
            onTap: () { /* Logika buka URL */ },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildInfoTile(
            icon: Icons.description_outlined,
            title: "Syarat & Ketentuan",
            onTap: () { /* Logika buka URL */ },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
           _buildInfoTile(
            icon: Icons.star_border_outlined,
            title: "Beri Rating Aplikasi",
            onTap: () { /* Logika buka Play Store/App Store */ },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: kTextColor),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
