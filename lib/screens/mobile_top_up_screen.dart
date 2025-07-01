import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class MobileTopUpScreen extends StatefulWidget {
  const MobileTopUpScreen({super.key});

  @override
  State<MobileTopUpScreen> createState() => _MobileTopUpScreenState();
}

class _MobileTopUpScreenState extends State<MobileTopUpScreen> {
  // Variabel dan controller dalam B. Inggris
  final _phoneNumberController = TextEditingController();
  String? _foundContact;
  int _selectedAmountIndex = -1;
  int _selectedPaymentMethod = 1;

  final List<Map<String, dynamic>> _amountOptions = [
    {'amount': 1, 'price': '15.000 IDR'},
    {'amount': 2, 'price': '25.000 IDR'},
    {'amount': 5, 'price': '50.000 IDR'},
  ];

  @override
  void initState() {
    super.initState();
    _phoneNumberController.addListener(_searchContact);
  }

  void _searchContact() {
    setState(() {
      if (_phoneNumberController.text == '0812') {
        _foundContact = 'Andy Kros';
      } else if (_phoneNumberController.text.length > 4) {
        _foundContact = 'not_found';
      } else {
        _foundContact = null;
      }
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFormValid = _phoneNumberController.text.isNotEmpty && _selectedAmountIndex != -1;
    String contactName = (_foundContact != null && _foundContact != 'not_found') ? _foundContact! : "Diri Sendiri";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Isi Ulang Pulsa', style: TextStyle(color: kTextColor)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Nomor telepon', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: 'Masukkan nomor telepon',
              border: OutlineInputBorder(),
            ),
          ),
          _buildContactInfo(),
          const SizedBox(height: 24),
          const Text('Pilih Jumlah', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _amountOptions.asMap().entries.map((entry) {
              int idx = entry.key;
              Map<String, dynamic> nominal = entry.value;
              return ChoiceChip(
                label: Text(nominal['price'] as String),
                labelStyle: TextStyle(color: _selectedAmountIndex == idx ? Colors.white : kTextColor),
                selected: _selectedAmountIndex == idx,
                onSelected: (bool selected) {
                  setState(() {
                    _selectedAmountIndex = selected ? idx : -1;
                  });
                },
                selectedColor: kPrimaryColor,
                backgroundColor: Colors.grey.shade200,
                showCheckmark: false,
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text('Metode Pembayaran', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildPaymentMethodTile(1, 'Dari Dompet (saldo)', '\$ 13 840'),
          _buildPaymentMethodTile(2, 'Dari Visa', '**** 3453'),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: isFormValid ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Mengisi pulsa untuk $contactName')),
              );
            } : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: isFormValid ? kPrimaryColor : Colors.grey,
            ),
            child: Text('Isi Ulang untuk $contactName'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    if (_foundContact == null) {
      return const SizedBox.shrink();
    } else if (_foundContact == 'not_found') {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          children: [
            Image.asset('assets/images/login.png', height: 60),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pencarian tidak ditemukan', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Nomor ini belum terdaftar. Undang sekarang!', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
        ),
        title: Text(_foundContact!),
        subtitle: Text(_phoneNumberController.text),
      );
    }
  }

  Widget _buildPaymentMethodTile(int value, String title, String subtitle) {
    return RadioListTile<int>(
      value: value,
      groupValue: _selectedPaymentMethod,
      onChanged: (int? newValue) {
        setState(() {
          _selectedPaymentMethod = newValue!;
        });
      },
      title: Text(title),
      subtitle: Text(subtitle),
      activeColor: kPrimaryColor,
      contentPadding: EdgeInsets.zero,
    );
  }
}