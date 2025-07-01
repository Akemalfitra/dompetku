// lib/screens/transfer_bank_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class TransferBankScreen extends StatefulWidget {
  const TransferBankScreen({super.key});

  @override
  State<TransferBankScreen> createState() => _TransferBankScreenState();
}

class _TransferBankScreenState extends State<TransferBankScreen> {
  // State management
  String? _selectedBank;
  final _accountNumberController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isAccountVerified = false;
  String _verifiedName = "";
  bool _isLoading = false;

  // Dummy data
  final List<Map<String, String>> _banks = [
    {'name': 'BCA', 'logo': ''},
    {'name': 'Mandiri', 'logo': ''},
    {'name': 'BNI', 'logo': ''},
    {'name': 'BRI', 'logo': ''},
    {'name': 'CIMB Niaga', 'logo': ''},
    {'name': 'Bank Syariah Indonesia', 'logo': ''},
    {'name': 'PermataBank', 'logo': ''},
  ];

  @override
  void dispose() {
    _accountNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // --- LOGIC FUNCTIONS ---
  void _showBankSelection() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Pilih Bank Tujuan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _banks.length,
                itemBuilder: (context, index) {
                  final bank = _banks[index];
                  return ListTile(
                    title: Text(bank['name']!),
                    onTap: () {
                      setState(() {
                        _selectedBank = bank['name'];
                        _isAccountVerified = false; // Reset verifikasi saat bank diganti
                        _verifiedName = "";
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Future<void> _verifyAccount() async {
    if (_accountNumberController.text.isEmpty || _selectedBank == null) return;
    
    setState(() => _isLoading = true);
    // Simulasi panggilan API
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      _isAccountVerified = true;
      _verifiedName = "Akem"; // Nama hasil verifikasi
    });
  }

  // --- UI BUILDER WIDGETS ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Transfer Bank', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.shade200,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle("Tujuan Transfer"),
          _buildDestinationForm(),
          const SizedBox(height: 24),
          _buildSectionTitle("Jumlah Transfer"),
          _buildAmountForm(),
        ],
      ),
      bottomNavigationBar: _buildContinueButton(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
    );
  }

  Widget _buildDestinationForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: _showBankSelection,
            child: InputDecorator(
              decoration: _buildInputDecoration(label: "Bank Tujuan")
                  .copyWith(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedBank ?? "Pilih bank", style: TextStyle(color: _selectedBank != null ? kTextColor : Colors.grey)),
                  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _accountNumberController,
            keyboardType: TextInputType.number,
            decoration: _buildInputDecoration(
              label: "Nomor Rekening",
              suffixIcon: TextButton(
                onPressed: _verifyAccount,
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text("Cek"),
              ),
            ),
          ),
          if (_isAccountVerified)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 18),
                  const SizedBox(width: 8),
                  Text("Rekening terverifikasi: $_verifiedName", style: const TextStyle(color: Colors.green)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAmountForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              prefixText: "Rp ",
              prefixStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
              labelText: "Masukkan Jumlah",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAmountChip("100.000"),
              _buildAmountChip("250.000"),
              _buildAmountChip("500.000"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAmountChip(String amount) {
    return ActionChip(
      label: Text("Rp $amount"),
      onPressed: () {
        _amountController.text = amount;
      },
      backgroundColor: kPrimaryColor.withAlpha(20),
      labelStyle: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
    );
  }

  InputDecoration _buildInputDecoration({required String label, Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 55),
        ),
        onPressed: _isAccountVerified ? () {
          // Navigasi ke halaman konfirmasi
        } : null,
        child: const Text('Lanjutkan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
