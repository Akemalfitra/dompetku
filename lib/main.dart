import 'package:dompetku/screens/add_card_screen.dart';
import 'package:dompetku/screens/confirm_bill_screen.dart';
import 'package:dompetku/screens/deposit_screen.dart';
import 'package:dompetku/screens/electric_bill_screen.dart';
import 'package:dompetku/screens/electricity_calculator_screen.dart';
import 'package:dompetku/screens/main_screen.dart';
import 'package:dompetku/screens/mobile_top_up_screen.dart';
import 'package:dompetku/screens/notifications_screen.dart';
import 'package:dompetku/screens/payment_history_screen.dart';
import 'package:dompetku/screens/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:dompetku/screens/onboarding_screen.dart';
import 'package:dompetku/screens/login_screen.dart';
import 'package:dompetku/screens/signup_screen.dart';
import 'package:dompetku/screens/forgot_password_screen.dart';
import 'package:dompetku/screens/otp_screen.dart';
import 'package:dompetku/screens/reset_password_screen.dart';
import 'package:dompetku/screens/transfer_screen.dart';
import 'package:dompetku/screens/confirm_transfer_screen.dart';
import 'package:dompetku/screens/services/bayar_tagihan_screen.dart';
import 'package:dompetku/screens/services/diskon_screen.dart';
import 'package:dompetku/screens/services/belanja_screen.dart';
import 'package:dompetku/screens/services/promo_belanja_screen.dart';
import 'package:dompetku/screens/services/tiket_bola_screen.dart';
import 'package:dompetku/screens/services/kesehatan_screen.dart';
import 'package:dompetku/screens/services/internet_screen.dart' as services_internet;
import 'package:dompetku/screens/services/musik_screen.dart';
import 'package:dompetku/screens/services/tiket_screen.dart';
import 'package:dompetku/screens/services/game_screen.dart';
import 'package:dompetku/screens/services/lainnya_screen.dart';
import 'package:dompetku/screens/settings/change_password_screen.dart';
import 'package:dompetku/screens/settings/set_pin_screen.dart';
import 'package:dompetku/screens/settings/quick_payment_screen.dart';
import 'package:dompetku/screens/settings/language_screen.dart';
import 'package:dompetku/screens/settings/app_info_screen.dart';

// --- TAMBAHKAN IMPORT BARU ---
import 'package:dompetku/screens/internet_screen.dart';
import 'package:dompetku/screens/voucher_screen.dart';
import 'package:dompetku/screens/insurance_screen.dart';
import 'package:dompetku/screens/merchant_screen.dart';


// Variabel warna global
const kPrimaryColor = Color(0xFF4A64FE);
const kTextColor = Color(0xFF333333);
const kSubtitleColor = Colors.grey;

void main() {
  runApp(const DompetkuApp());
}

class DompetkuApp extends StatelessWidget {
  const DompetkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dompetku',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: kTextColor),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kPrimaryColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/otp': (context) => const OTPScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/main': (context) => const MainScreen(),
        '/add_card': (context) => const AddCardScreen(),
        '/services': (context) => const ServicesScreen(),
        '/mobile_top_up': (context) => const MobileTopUpScreen(),
        '/electric_bill': (context) => const ElectricBillScreen(),
        '/confirm_bill': (context) => const ConfirmBillScreen(),
        '/electricity_calculator': (context) =>
            const ElectricityCalculatorScreen(),
        '/payment_history': (context) => const PaymentHistoryScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/deposit': (context) => const DepositScreen(),
        '/transfer': (context) => const TransferScreen(),
        '/confirm_transfer': (context) => const ConfirmTransferScreen(),
        '/bayar_tagihan': (context) => const BayarTagihanScreen(),
        '/diskon': (context) => const DiskonScreen(),
        '/belanja': (context) => const BelanjaScreen(),
        '/promo_belanja': (context) => const PromoBelanjaScreen(),
        '/tiket_bola': (context) => const TiketBolaScreen(),
        '/kesehatan': (context) => const KesehatanScreen(),
        '/internet_services': (context) => const services_internet.InternetScreen(),
        '/musik': (context) => const MusikScreen(),
        '/tiket': (context) => const TiketScreen(),
        '/game': (context) => const GameScreen(),
        '/lainnya': (context) => const LainnyaScreen(),
        '/change_password': (context) => const ChangePasswordScreen(),
        '/set_pin': (context) => const SetPinScreen(),
        '/quick_payment': (context) => const QuickPaymentScreen(),
        '/language': (context) => const LanguageScreen(),
        '/app_info': (context) => const AppInfoScreen(),

        // --- TAMBAHKAN RUTE BARU DI SINI ---
        '/internet': (context) => const InternetScreen(),
        '/voucher': (context) => const VoucherScreen(),
        '/insurance': (context) => const InsuranceScreen(),
        '/merchant': (context) => const MerchantScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dompetku', style: TextStyle(color: kTextColor)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selamat Datang di Dompetku',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kTextColor),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/services');
              },
              child: const Text('Lihat Layanan'),
            ),
          ],
        ),
      ),
    );
  }
}
