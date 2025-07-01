import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Center(
                  child: Image.asset(
                    'assets/images/signup.png',
                    height: 150,
                  ),
                ),
                const SizedBox(height: 48),
                const Text(
                  "Ayo, daftarkan diri Anda",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "Sudah punya akun? ",
                      style: TextStyle(color: kSubtitleColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Kembali ke halaman login
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Masuk sekarang',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                 TextField(
                  decoration: InputDecoration(
                    labelText: 'Nomor ponsel Anda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Logika lanjut ke tahap berikutnya (misal: verifikasi OTP)
                      Navigator.pushNamed(context, '/otp');
                    },
                    child: const Text('Lanjutkan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}