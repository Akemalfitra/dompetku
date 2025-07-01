// lib/screens/mobile_top_up_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class MobileTopUpScreen extends StatefulWidget {
  const MobileTopUpScreen({super.key});

  @override
  State<MobileTopUpScreen> createState() => _MobileTopUpScreenState();
}

class _MobileTopUpScreenState extends State<MobileTopUpScreen> {
  final _phoneController = TextEditingController();
  String _detectedOperator = '';
  int? _selectedNominal;

  // Dummy data
  final List<int> _pulsaNominals = [10000, 25000, 50000, 100000, 200000, 500000];
  final List<Map<String, String>> _dataPackages = [
    {'name': 'Internet OMG!', 'size': '4.5 GB', 'price': 'Rp 41.000'},
    {'name': 'Combo SAKTI', 'size': '17 GB', 'price': 'Rp 54.000'},
    {'name': 'Internet SAKTI', 'size': '11 GB', 'price': 'Rp 28.000'},
    {'name': 'GigaNet', 'size': '55 GB', 'price': 'Rp 125.000'},
  ];

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_detectOperator);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_detectOperator);
    _phoneController.dispose();
    super.dispose();
  }

  void _detectOperator() {
    String phone = _phoneController.text;
    String newOperator = '';
    if (phone.startsWith('0812') || phone.startsWith('0813') || phone.startsWith('0821')) {
      newOperator = 'Telkomsel';
    } else if (phone.startsWith('0817') || phone.startsWith('0818') || phone.startsWith('0819')) {
      newOperator = 'XL';
    } else if (phone.startsWith('0895') || phone.startsWith('0896')) {
      newOperator = 'Tri';
    } else if (phone.startsWith('0856') || phone.startsWith('0857')) {
      newOperator = 'Indosat';
    }
    if (newOperator != _detectedOperator) {
      setState(() => _detectedOperator = newOperator);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          title: const Text('Isi Ulang & Paket Data', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 1,
          shadowColor: Colors.grey.shade200,
          iconTheme: const IconThemeData(color: kTextColor),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: kPrimaryColor,
            labelColor: kPrimaryColor,
            unselectedLabelColor: Colors.grey,
            tabs: [Tab(text: 'Pulsa'), Tab(text: 'Paket Data')],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPulsaTab(),
            _buildDataTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildPulsaTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildPhoneInput(),
        const SizedBox(height: 24),
        const Text("Pilih Nominal Pulsa", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildNominalGrid(),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _selectedNominal != null && _phoneController.text.isNotEmpty ? () {} : null,
          child: const Text("Beli Pulsa"),
        ),
      ],
    );
  }

  Widget _buildDataTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildPhoneInput(),
        const SizedBox(height: 24),
        const Text("Pilih Paket Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _dataPackages.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final package = _dataPackages[index];
            return _buildDataPackageCard(package);
          },
        )
      ],
    );
  }

  Widget _buildPhoneInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nomor Telepon", style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "08xxxxxxxxxx",
              border: const UnderlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.contact_phone_outlined, color: kPrimaryColor),
                onPressed: () {},
              ),
            ),
          ),
          if (_detectedOperator.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Operator: $_detectedOperator", style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildNominalGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _pulsaNominals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.0,
      ),
      itemBuilder: (context, index) {
        final nominal = _pulsaNominals[index];
        final isSelected = _selectedNominal == nominal;
        return GestureDetector(
          onTap: () => setState(() => _selectedNominal = nominal),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? kPrimaryColor.withAlpha(30) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? kPrimaryColor : Colors.grey.shade300, width: 1.5),
            ),
            child: Text(
              "Rp ${nominal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
              style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? kPrimaryColor : kTextColor),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDataPackageCard(Map<String, String> package) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(package['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(package['size']!, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Text(package['price']!, style: const TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor, fontSize: 16)),
        ],
      ),
    );
  }
}
