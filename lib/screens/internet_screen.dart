// lib/screens/internet_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class InternetScreen extends StatefulWidget {
  const InternetScreen({super.key});

  @override
  State<InternetScreen> createState() => _InternetScreenState();
}

class _InternetScreenState extends State<InternetScreen> {
  String? _selectedProvider;
  final _customerIdController = TextEditingController();

  // Anda bisa menambahkan path logo jika ada di assets
  final List<Map<String, String>> _providers = [
    {'name': 'IndiHome', 'logo': ''},
    {'name': 'First Media', 'logo': ''},
    {'name': 'MyRepublic', 'logo': ''},
    {'name': 'Biznet Home', 'logo': ''},
    {'name': 'MNC Play', 'logo': ''},
  ];

  @override
  void dispose() {
    _customerIdController.dispose();
    super.dispose();
  }

  void _showProviderSelection() {
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
              child: Text("Pilih Penyedia", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _providers.length,
                itemBuilder: (context, index) {
                  final provider = _providers[index];
                  return ListTile(
                    title: Text(provider['name']!),
                    onTap: () {
                      setState(() {
                        _selectedProvider = provider['name'];
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
      appBar: AppBar(
        title: const Text('Internet & TV Kabel', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.shade200,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildInputField(
            controller: _customerIdController,
            label: "Nomor Pelanggan",
            hint: "Masukkan nomor pelanggan Anda",
          ),
          const SizedBox(height: 24),
          _buildProviderSelector(),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _customerIdController.text.isNotEmpty && _selectedProvider != null
                ? () {}
                : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              backgroundColor: _customerIdController.text.isNotEmpty && _selectedProvider != null
                  ? kPrimaryColor
                  : Colors.grey.shade400,
            ),
            child: const Text("Cek Tagihan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }

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

  Widget _buildProviderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Penyedia Layanan",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kTextColor),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: _showProviderSelection,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedProvider ?? "Pilih penyedia",
                  style: TextStyle(color: _selectedProvider != null ? kTextColor : Colors.grey),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
