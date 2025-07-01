import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _isFaceIdEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), 
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Pengaturan", style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          _buildProfileCard(),
          const SizedBox(height: 24),

          // --- Grup Pengaturan Akun ---
          _buildSettingsGroup(
            title: "Akun",
            children: [
              _buildSettingsTile(
                icon: Icons.lock_outline_rounded,
                title: "Ubah Kata Sandi",
                onTap: () {
                  Navigator.pushNamed(context, '/change_password');
                },
              ),
              const Divider(height: 1),
              _buildSettingsTile(
                icon: Icons.pin_outlined,
                title: "Atur Kode PIN",
                onTap: () {
                  Navigator.pushNamed(context, '/set_pin');
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // --- Grup Pengaturan Keamanan ---
          _buildSettingsGroup(
            title: "Keamanan",
            children: [
              _buildSettingsTile(
                icon: Icons.credit_card_outlined,
                title: "Pembayaran Cepat",
                onTap: () {
                  Navigator.pushNamed(context, '/quick_payment');
                },
              ),
              const Divider(height: 1),
              _buildSwitchTile( 
                icon: Icons.face_retouching_natural_outlined,
                title: "Gunakan Face ID",
                value: _isFaceIdEnabled,
                onChanged: (value) {
                  setState(() => _isFaceIdEnabled = value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // --- Grup Pengaturan Lainnya ---
          _buildSettingsGroup(
            title: "Lainnya",
            children: [
              _buildSettingsTile(
                icon: Icons.language_outlined,
                title: "Bahasa",
                trailing: const Text("Indonesia", style: TextStyle(color: Colors.grey)),
                onTap: () {
                  Navigator.pushNamed(context, '/language');
                },
              ),
              const Divider(height: 1),
              _buildSettingsTile(
                icon: Icons.info_outline_rounded,
                title: "Informasi Aplikasi",
                 trailing: const Text("Versi 1.0.0", style: TextStyle(color: Colors.grey)),
                onTap: () {
                  Navigator.pushNamed(context, '/app_info');
                },
              ),
            ],
          ),
          const SizedBox(height: 32),

          // --- Tombol Keluar ---
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: kPrimaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "akem",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: kTextColor),
                ),
                SizedBox(height: 2),
                Text(
                  "user@email.com",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget _buildSettingsGroup({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade600, letterSpacing: 0.5),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: kPrimaryColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: kPrimaryColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      value: value,
      onChanged: onChanged,
      activeColor: kPrimaryColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildLogoutButton() {
     return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Keluar"),
            content: const Text("Apakah Anda yakin ingin keluar dari akun Anda?"),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Batal")),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                child: const Text("Ya", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text(
              "Keluar dari Akun",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
