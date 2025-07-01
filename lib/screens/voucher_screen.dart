// lib/screens/voucher_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  String _selectedCategory = "Semua";

  // Data dummy untuk voucher
  final List<Map<String, String>> _vouchers = [
    {'brand': 'Kopi Kenangan', 'title': 'Diskon 50% Kopi', 'price': 'Rp 10.000', 'logo': 'kopi_kenangan.png', 'category': 'Makanan'},
    {'brand': 'H&M', 'title': 'Cashback 20%', 'price': 'Gratis', 'logo': 'hm.png', 'category': 'Belanja'},
    {'brand': 'CGV', 'title': 'Beli 1 Gratis 1 Tiket', 'price': 'Rp 45.000', 'logo': 'cgv.png', 'category': 'Hiburan'},
    {'brand': 'Traveloka', 'title': 'Diskon Hotel 15%', 'price': 'Gratis', 'logo': 'traveloka.png', 'category': 'Perjalanan'},
    {'brand': 'McDonald\'s', 'title': 'Gratis McFlurry', 'price': 'Rp 5.000', 'logo': 'mcd.png', 'category': 'Makanan'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Voucher Digital', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.shade200,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSearchBar(),
          _buildCategoryChips(),
          _buildVoucherList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari voucher atau merchant...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = ["Semua", "Makanan", "Belanja", "Hiburan", "Perjalanan"];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedCategory = category);
                }
              },
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.white,
              selectedColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: kPrimaryColor.withOpacity(0.5)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVoucherList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Populer Minggu Ini", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _vouchers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final voucher = _vouchers[index];
              return _buildVoucherCard(voucher);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherCard(Map<String, String> voucher) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Ganti dengan Image.asset jika logo ada di assets
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.storefront, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(voucher['brand']!, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 2),
                Text(voucher['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(voucher['price']!, style: const TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor, fontSize: 16)),
              const Text("Harga", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}
