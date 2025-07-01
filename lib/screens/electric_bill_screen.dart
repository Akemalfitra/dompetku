// lib/screens/electric_bill_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class ElectricBillScreen extends StatefulWidget {
  const ElectricBillScreen({super.key});

  @override
  State<ElectricBillScreen> createState() => _ElectricBillScreenState();
}

class _ElectricBillScreenState extends State<ElectricBillScreen> {
  // --- State untuk Tab Token ---
  final _tokenController = TextEditingController();
  int? _selectedNominal;
  final List<Map<String, dynamic>> _nominals = [
    {'value': 20000, 'label': '20k'},
    {'value': 50000, 'label': '50k'},
    {'value': 100000, 'label': '100k'},
    {'value': 200000, 'label': '200k'},
    {'value': 500000, 'label': '500k'},
    {'value': 1000000, 'label': '1 Jt'},
  ];

  // --- State untuk Tab Tagihan ---
  final _tagihanController = TextEditingController();
  bool _showBillDetails = false;

  @override
  void dispose() {
    _tokenController.dispose();
    _tagihanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DefaultTabController adalah cara terbaik untuk mengelola TabBar dan TabBarView
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: _buildAppBar(),
        body: TabBarView(
          children: [
            _buildTokenTab(), // Konten untuk tab pertama
            _buildTagihanTab(), // Konten untuk tab kedua
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Pembayaran Listrik', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.grey.shade200,
      iconTheme: const IconThemeData(color: kTextColor),
      centerTitle: true,
      bottom: const TabBar(
        indicatorColor: kPrimaryColor,
        indicatorWeight: 3,
        labelColor: kPrimaryColor,
        unselectedLabelColor: Colors.grey,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        tabs: [
          Tab(text: 'Token Listrik'),
          Tab(text: 'Tagihan Listrik'),
        ],
      ),
    );
  }

  // --- WIDGET UNTUK TAB TOKEN LISTRIK ---
  Widget _buildTokenTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildInputField(
          controller: _tokenController,
          label: "Nomor Meter / ID Pelanggan",
          hint: "Contoh: 32012345678",
        ),
        _buildSavedNumber(
          name: "Rumah Akem", 
          number: "32087654321",
          onTap: () => setState(() => _tokenController.text = "32087654321"),
        ),
        const SizedBox(height: 24),
        const Text(
          "Pilih Nominal Token",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kTextColor),
        ),
        const SizedBox(height: 16),
        _buildNominalGrid(),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _selectedNominal != null && _tokenController.text.isNotEmpty ? () {
            Navigator.pushNamed(context, '/confirm_bill');
          } : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 55),
            backgroundColor: _selectedNominal != null && _tokenController.text.isNotEmpty ? kPrimaryColor : Colors.grey.shade400,
          ),
          child: const Text("Lanjutkan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildNominalGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _nominals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (context, index) {
        final nominal = _nominals[index];
        final isSelected = _selectedNominal == nominal['value'];
        return GestureDetector(
          onTap: () => setState(() => _selectedNominal = nominal['value']),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? kPrimaryColor.withAlpha(30) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? kPrimaryColor : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Text(
              nominal['label'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isSelected ? kPrimaryColor : kTextColor,
              ),
            ),
          ),
        );
      },
    );
  }

  // --- WIDGET UNTUK TAB TAGIHAN LISTRIK ---
  Widget _buildTagihanTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildInputField(
          controller: _tagihanController,
          label: "ID Pelanggan",
          hint: "Contoh: 512345678901",
        ),
         _buildSavedNumber(
          name: "Kantor", 
          number: "512345678901",
          onTap: () => setState(() => _tagihanController.text = "512345678901"),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _tagihanController.text.isNotEmpty ? () => setState(() => _showBillDetails = true) : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 55),
            backgroundColor: _tagihanController.text.isNotEmpty ? kPrimaryColor : Colors.grey.shade400,
          ),
          child: const Text("Cek Tagihan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        if (_showBillDetails) ...[
          const SizedBox(height: 24),
          _buildBillDetailsCard(),
        ]
      ],
    );
  }

  // --- WIDGET HELPER YANG BISA DIGUNAKAN KEMBALI ---
  Widget _buildInputField({required TextEditingController controller, required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kTextColor),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSavedNumber({required String name, required String number, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            const Icon(Icons.bookmark_border_rounded, color: kPrimaryColor, size: 18),
            const SizedBox(width: 8),
            Text(name, style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500)),
            const SizedBox(width: 4),
            Text("($number)", style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildBillDetailsCard() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Detail Tagihan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildInfoRow("Nama Pelanggan", "Akem"),
              _buildInfoRow("Periode", "Juni 2025"),
              _buildInfoRow("Stand Meter", "001234 - 001567"),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              _buildInfoRow("Total Tagihan", "Rp 245.500", isAmount: true),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/confirm_bill');
          },
          style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 55)),
          child: const Text("Bayar Tagihan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isAmount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isAmount ? FontWeight.bold : FontWeight.w500,
              fontSize: isAmount ? 18 : 14,
              color: kTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
