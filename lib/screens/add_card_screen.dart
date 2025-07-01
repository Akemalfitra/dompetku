import 'package:dompetku/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:lottie/lottie.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  CreditCardBrand? cardBrand;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Map<String, dynamic> _getCardStyling(CreditCardBrand? brand) {
    const BoxDecoration defaultDecoration = BoxDecoration(
      gradient: LinearGradient(
        colors: [kPrimaryColor, Color(0xff00695c)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
    BoxDecoration decoration = defaultDecoration;
    Widget? logo;

    String brandName = brand?.brandName?.name ?? '';

    switch (brandName) {
      case 'visa':
        decoration = const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1a1e6c), Color(0xFF2652a1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
        logo = Image.asset('assets/images/logos/visa.png', height: 40, fit: BoxFit.contain);
        break;
      case 'mastercard':
        decoration = const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF222222), Color(0xFF444444)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
        logo = Image.asset('assets/images/logos/mastercard.png', height: 50, fit: BoxFit.contain);
        break;
      default:
        decoration = defaultDecoration;
        logo = null;
        break;
    }

    return {'decoration': decoration, 'logo': logo};
  }


  @override
  Widget build(BuildContext context) {
    final cardStyle = _getCardStyling(cardBrand);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Tambah Kartu Baru', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 210,
                  margin: const EdgeInsets.all(16),
                  decoration: (cardStyle['decoration'] as BoxDecoration).copyWith(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  onCreditCardWidgetChange: (CreditCardBrand brand) {
                    if (brand.brandName != cardBrand?.brandName) {
                      // FIX: Menunda setState untuk menghindari error build
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) { // Selalu cek 'mounted' sebelum setState di async callback
                          setState(() {
                            cardBrand = brand;
                          });
                        }
                      });
                    }
                  },
                  cardBgColor: Colors.transparent,
                  glassmorphismConfig: Glassmorphism(
                    blurX: 5.0,
                    blurY: 5.0,
                    gradient: LinearGradient(
                      colors: [Colors.white.withAlpha(26), Colors.white.withAlpha(51)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  right: 35,
                  top: 35,
                  child: cardStyle['logo'] ?? const SizedBox.shrink(),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    CreditCardForm(
                      formKey: formKey,
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      onCreditCardModelChange: onCreditCardModelChange,
                      inputConfiguration: InputConfiguration(
                        cardHolderDecoration: _buildInputDecoration(label: 'Nama Pemegang Kartu'),
                        cardNumberDecoration: _buildInputDecoration(label: 'Nomor Kartu', hint: 'XXXX XXXX XXXX XXXX'),
                        expiryDateDecoration: _buildInputDecoration(label: 'Bulan/Tahun', hint: 'BB/TT'),
                        cvvCodeDecoration: _buildInputDecoration(label: 'CVV', hint: 'XXX'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 55),
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 5,
                          shadowColor: kPrimaryColor.withAlpha(100),
                        ),
                        onPressed: _validateAndSubmit,
                        child: const Text('Simpan Kartu', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({required String label, String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Colors.grey),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: kPrimaryColor, width: 2)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    if (mounted) {
      setState(() {
        cardNumber = creditCardModel.cardNumber;
        expiryDate = creditCardModel.expiryDate;
        cardHolderName = creditCardModel.cardHolderName;
        cvvCode = creditCardModel.cvvCode;
        isCvvFocused = creditCardModel.isCvvFocused;
      });
    }
  }

  void _validateAndSubmit() {
    if (formKey.currentState!.validate()) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
          height: 360,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/images/lottie/success checkmark.json', height: 150, repeat: false),
              const SizedBox(height: 16),
              const Text(
                'Kartu Berhasil Ditambahkan!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kTextColor),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sekarang Anda bisa bebas membayar dan berbelanja. Selamat menikmati! ✌️',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('Lanjutkan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}