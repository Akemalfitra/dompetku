// lib/screens/settings/set_pin_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  String _pin = "";

  void _onNumberPress(String number) {
    if (_pin.length < 6) {
      setState(() {
        _pin += number;
      });
    }
  }

  void _onBackspacePress() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Atur Kode PIN", style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const Text("Masukkan 6 digit PIN Anda", style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 24),
            _buildPinDots(),
            const Spacer(),
            _buildNumpad(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: index < _pin.length ? kPrimaryColor : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildNumpad() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 12,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        if (index == 9) return const SizedBox.shrink(); // Kosong
        if (index == 11) {
          return _buildNumpadButton(
            icon: Icons.backspace_outlined,
            onPressed: _onBackspacePress,
          );
        }
        final number = index == 10 ? '0' : (index + 1).toString();
        return _buildNumpadButton(
          text: number,
          onPressed: () => _onNumberPress(number),
        );
      },
    );
  }

  Widget _buildNumpadButton({String? text, IconData? icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40),
      child: Center(
        child: text != null
            ? Text(text, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor))
            : Icon(icon, color: kTextColor),
      ),
    );
  }
}
