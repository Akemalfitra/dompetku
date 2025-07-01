import 'package:flutter/material.dart';
import 'package:dompetku/main.dart'; // Impor untuk warna
import 'package:pinput/pinput.dart'; // Impor package pinput

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isPinCompleted = false;

  @override
  Widget build(BuildContext context) {
    // Nama variabel ini sudah benar
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, color: kTextColor),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Scaffold(
      appBar: AppBar(), // AppBar sederhana sudah cukup
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Otentikasi OTP',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text.rich(
                TextSpan(
                  text: 'Kode otentikasi telah dikirim ke ',
                  style: TextStyle(fontSize: 14, color: kSubtitleColor),
                  children: [
                    TextSpan(
                      text: '(+62) 812 3456 789', // Ganti dengan nomor dinamis
                      style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Center(
                child: Pinput(
                  length: 6,
                  // --- PERBAIKAN DI SINI ---
                  // Mengganti `defaultTheme` menjadi `defaultPinTheme`
                  defaultPinTheme: defaultPinTheme, 
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: kPrimaryColor),
                    ),
                  ),
                  onCompleted: (pin) {
                    setState(() {
                      isPinCompleted = true;
                    });
                  },
                  onChanged: (value) {
                     if (isPinCompleted) {
                       setState(() {
                         isPinCompleted = false;
                       });
                     }
                  },
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text.rich(
                    TextSpan(
                      text: "Tidak menerima kode? ",
                      style: TextStyle(color: kSubtitleColor),
                      children: [
                        TextSpan(
                          text: "Kirim ulang kode.",
                          style: TextStyle(color: kPrimaryColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isPinCompleted
                      ? () {
                          Navigator.pushNamed(context, '/reset_password');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPinCompleted ? kPrimaryColor : Colors.grey,
                  ),
                  child: const Text('Lanjutkan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}