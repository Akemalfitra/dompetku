import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

// Menjadi StatelessWidget karena tidak ada state validasi yang perlu dikelola
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(child: Image.asset('assets/images/login.png', height: 120)),
                const SizedBox(height: 48),
                const Text(
                  'Selamat datang kembali',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: kTextColor)
                ),
                const Text(
                  'Masuk untuk melanjutkan',
                  style: TextStyle(fontSize: 14, color: kSubtitleColor)
                ),
                const SizedBox(height: 32),

                // Form Nomor Telepon (tanpa validasi)
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nomor Ponsel',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                // Form Kata Sandi (tanpa validasi)
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                ),
                
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: const Text('Lupa kata sandi?')
                  ),
                ),
                const SizedBox(height: 24),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // Tombol login ini hanya simulasi, langsung navigasi ke halaman utama
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                    },
                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                    child: const Text("Masuk"),
                  ),
                ),
                const SizedBox(height: 48),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum punya akun? ", style: TextStyle(color: kSubtitleColor)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Daftar sekarang',
                        style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}