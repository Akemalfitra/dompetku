// lib/screens/transfer_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int _selectedTransactionType = 1; // Default ke 'Bank Lain'
  int _selectedBeneficiary = -1;
  String? _selectedBank;
  final _amountController = TextEditingController(text: "Rp 200.000");
  bool _saveBeneficiary = true;

  final List<Map<String, String>> _accounts = [
    {'name': 'VISA **** 1234', 'balance': 'Rp 10.000.000', 'type': 'card'},
    {'name': 'Rekening Tabungan', 'balance': 'Rp 25.500.000', 'type': 'bank'},
    {'name': 'Dompetku Utama', 'balance': 'Rp 1.590.100', 'type': 'wallet'},
  ];
  // --- FIX: Mengubah menjadi nullable untuk menghindari LateInitializationError ---
  Map<String, String>? _selectedAccount;

  // Data dummy untuk penerima
  final List<Map<String, String>> beneficiaries = [
    {'name': 'Emma', 'avatar': 'https://i.pravatar.cc/150?u=emma'},
    {'name': 'Justin', 'avatar': 'https://i.pravatar.cc/150?u=justin'},
    {'name': 'Amanda', 'avatar': 'https://i.pravatar.cc/150?u=amanda'},
    {'name': 'Alex', 'avatar': 'https://i.pravatar.cc/150?u=alex'},
  ];

  // Controller untuk form penerima baru
  final _newBeneficiaryNameController = TextEditingController();
  final _newBeneficiaryAccountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set rekening pertama sebagai default, jika ada
    if (_accounts.isNotEmpty) {
      _selectedAccount = _accounts[0];
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _newBeneficiaryNameController.dispose();
    _newBeneficiaryAccountController.dispose();
    super.dispose();
  }

  // Method untuk menampilkan bottom sheet tambah penerima
  void _showAddBeneficiarySheet() {
    _newBeneficiaryNameController.clear();
    _newBeneficiaryAccountController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Tambah Penerima Baru", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              TextFormField(
                controller: _newBeneficiaryNameController,
                decoration: _buildInputDecoration(label: "Nama Penerima", icon: Icons.person_outline),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _newBeneficiaryAccountController,
                decoration: _buildInputDecoration(label: "Nomor Rekening/Kartu", icon: Icons.credit_card),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_newBeneficiaryNameController.text.isNotEmpty &&
                      _newBeneficiaryAccountController.text.isNotEmpty) {
                    setState(() {
                      final newBeneficiary = {
                        'name': _newBeneficiaryNameController.text,
                        'avatar': 'https://i.pravatar.cc/150?u=${DateTime.now().millisecondsSinceEpoch}',
                      };
                      beneficiaries.add(newBeneficiary);
                      _selectedBeneficiary = beneficiaries.length - 1;
                    });
                    Navigator.pop(context); // Tutup bottom sheet
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                ),
                child: const Text("Simpan Penerima"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Method untuk pemilihan rekening
  void _showAccountSelection() {
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
              child: Text("Pilih Rekening Sumber", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _accounts.length,
                itemBuilder: (context, index) {
                  final account = _accounts[index];
                  final isSelected = account['name'] == _selectedAccount?['name'];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: kPrimaryColor.withAlpha(30),
                      child: Icon(
                        account['type'] == 'card'
                            ? Icons.credit_card
                            : account['type'] == 'bank'
                                ? Icons.account_balance
                                : Icons.wallet_outlined,
                        color: kPrimaryColor,
                      ),
                    ),
                    title: Text(account['name']!),
                    subtitle: Text("Saldo: ${account['balance']!}"),
                    trailing: isSelected ? const Icon(Icons.check_circle, color: kPrimaryColor) : null,
                    onTap: () {
                      setState(() {
                        _selectedAccount = account;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("Dari Rekening"),
          _buildAccountSelector(),
          const SizedBox(height: 24),
          _buildSectionTitle("Pilih Penerima"),
          _buildBeneficiarySelector(),
          const SizedBox(height: 24),
          _buildSectionTitle("Detail Transfer"),
          _buildTransferForm(),
        ],
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Transfer', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: kTextColor),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.qr_code_scanner_rounded),
        )
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
    );
  }

  // Widget pemilih rekening diperbarui
  Widget _buildAccountSelector() {
    // --- FIX: Menangani kasus jika _selectedAccount masih null saat build pertama ---
    if (_selectedAccount == null) {
      return const Card(child: ListTile(title: Text("Memuat rekening...")));
    }

    IconData iconData;
    switch (_selectedAccount!['type']) {
      case 'card':
        iconData = Icons.credit_card;
        break;
      case 'bank':
        iconData = Icons.account_balance;
        break;
      default:
        iconData = Icons.wallet_outlined;
    }

    return InkWell(
      onTap: _showAccountSelection,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: Icon(iconData, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_selectedAccount!['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Saldo: ${_selectedAccount!['balance']!}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildBeneficiarySelector() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: beneficiaries.length + 1, // +1 untuk tombol Tambah
        itemBuilder: (context, index) {
          if (index == 0) {
            // Tombol Tambah Penerima Baru
            return GestureDetector(
              onTap: _showAddBeneficiarySheet,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: kPrimaryColor.withAlpha(30),
                      child: const Icon(Icons.add, color: kPrimaryColor, size: 28),
                    ),
                    const SizedBox(height: 8),
                    const Text("Baru", style: TextStyle(fontSize: 12, color: kTextColor)),
                  ],
                ),
              ),
            );
          }
          final beneficiary = beneficiaries[index - 1];
          final isSelected = _selectedBeneficiary == (index - 1);
          return GestureDetector(
            onTap: () => setState(() => _selectedBeneficiary = index - 1),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(beneficiary['avatar']!),
                    child: isSelected
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                            child: const Icon(Icons.check, color: Colors.white),
                          )
                        : null,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    beneficiary['name']!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? kPrimaryColor : kTextColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransferForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildSegmentedControl(),
          const SizedBox(height: 20),
          if (_selectedTransactionType == 1) ...[
            _buildBankSelector(),
            const SizedBox(height: 16),
          ],
          TextFormField(
            decoration: _buildInputDecoration(label: "Nomor Rekening/Kartu", icon: Icons.credit_card),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _amountController,
            decoration: _buildInputDecoration(label: "Jumlah", icon: Icons.monetization_on_outlined),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: _buildInputDecoration(label: "Catatan (Opsional)", icon: Icons.note_alt_outlined),
          ),
          CheckboxListTile(
            title: const Text("Simpan sebagai penerima favorit", style: TextStyle(fontSize: 14)),
            value: _saveBeneficiary,
            onChanged: (val) => setState(() => _saveBeneficiary = val!),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            activeColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl() {
    final types = ["Antar Dompetku", "Bank Lain"];
    return SegmentedButton<int>(
      segments: [
        for (int i = 0; i < types.length; i++)
          ButtonSegment<int>(value: i, label: Text(types[i])),
      ],
      selected: {_selectedTransactionType},
      onSelectionChanged: (newSelection) {
        setState(() => _selectedTransactionType = newSelection.first);
      },
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.grey.shade200,
        selectedBackgroundColor: kPrimaryColor,
        selectedForegroundColor: Colors.white,
        foregroundColor: kTextColor,
      ),
    );
  }

  Widget _buildBankSelector() {
    return InkWell(
      onTap: _showBankSelection,
      child: InputDecorator(
        decoration: _buildInputDecoration(label: "Pilih Bank", icon: Icons.account_balance_outlined)
            .copyWith(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_selectedBank ?? "Pilih bank tujuan", style: TextStyle(color: _selectedBank != null ? kTextColor : Colors.grey)),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({required String label, required IconData icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  void _showBankSelection() {
    final banks = ["BCA", "Mandiri", "BNI", "BRI", "CIMB Niaga", "Bank Syariah Indonesia"];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          children: [
            const Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Pilih Bank", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: banks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(banks[index]),
                    onTap: () {
                      setState(() => _selectedBank = banks[index]);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/confirm_transfer');
        },
        child: const Text('Lanjutkan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
