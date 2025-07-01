// lib/screens/settings/change_password_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  // Controller untuk validasi konfirmasi sandi
  final _newPasswordController = TextEditingController();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Ubah Kata Sandi",
            style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildInfoBanner(), // Banner informasi yang lebih menarik
            const SizedBox(height: 24),

            // Field Kata Sandi Saat Ini
            TextFormField(
              obscureText: !_isOldPasswordVisible,
              decoration: _buildInputDecoration(
                label: "Sandi Saat Ini",
                toggleVisibility: () {
                  setState(
                      () => _isOldPasswordVisible = !_isOldPasswordVisible);
                },
                isVisible: _isOldPasswordVisible,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Sandi saat ini tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Field Kata Sandi Baru
            TextFormField(
              controller: _newPasswordController, // Tambahkan controller
              obscureText: !_isNewPasswordVisible,
              decoration: _buildInputDecoration(
                label: "Sandi Baru",
                toggleVisibility: () {
                  setState(
                      () => _isNewPasswordVisible = !_isNewPasswordVisible);
                },
                isVisible: _isNewPasswordVisible,
              ),
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'Sandi minimal 8 karakter';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Field Konfirmasi Sandi Baru
            TextFormField(
              obscureText: !_isConfirmPasswordVisible,
              decoration: _buildInputDecoration(
                label: "Konfirmasi Sandi Baru",
                toggleVisibility: () {
                  setState(() =>
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                },
                isVisible: _isConfirmPasswordVisible,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Konfirmasi sandi tidak boleh kosong';
                }
                // Validasi baru: Cek jika sandi cocok
                if (value != _newPasswordController.text) {
                  return 'Sandi tidak cocok';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Tombol Simpan
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Kata sandi berhasil diubah!')),
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Simpan Perubahan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // Desain Input Field yang diperbarui
  InputDecoration _buildInputDecoration({
    required String label,
    required VoidCallback toggleVisibility,
    required bool isVisible,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      floatingLabelStyle: const TextStyle(color: kPrimaryColor),
      filled: true,
      fillColor: Colors.white,
      suffixIcon: IconButton(
        icon: Icon(
          isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: Colors.grey,
        ),
        onPressed: toggleVisibility,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }

  // Widget baru untuk banner informasi
  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: kPrimaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Jangan sebarkan kata sandi Anda kepada siapapun.",
              style: TextStyle(color: kPrimaryColor.withOpacity(0.8)),
            ),
          ),
        ],
      ),
    );
  }
}