// lib/screens/tabs/activities_tab.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';
import 'package:dompetku/widgets/transaction_list_item.dart';

class ActivitiesTab extends StatefulWidget {
  const ActivitiesTab({super.key});

  @override
  State<ActivitiesTab> createState() => _ActivitiesTabState();
}

class _ActivitiesTabState extends State<ActivitiesTab> {
  final List<Map<String, dynamic>> transactionGroups = [
    {
      'date': 'Hari Ini, 30 Juni 2025', // Tanggal disesuaikan
      'transactions': [
        {'title': 'Transfer ke Kathryn Yu', 'amount': -103.00, 'type': 'keluar'},
        {'title': 'Terima dari GoPay', 'amount': 457.00, 'type': 'masuk'},
        {'title': 'Bayar Tagihan Listrik', 'amount': -45.50, 'type': 'keluar'},
      ]
    },
    {
      'date': 'Kemarin, 29 Juni 2025',
      'transactions': [
        {'title': 'Transfer ke Lellie Alexander', 'amount': -103.00, 'type': 'keluar'},
        {'title': 'Terima dari Andy Kros', 'amount': 1003.00, 'type': 'masuk'},
      ]
    },
    {
      'date': 'Jumat, 27 Juni 2025',
      'transactions': [
        {'title': 'Top Up Saldo', 'amount': 500.00, 'type': 'masuk'},
        {'title': 'Belanja di Supermarket', 'amount': -89.75, 'type': 'keluar'},
      ]
    },
  ];

  String _selectedFilter = 'Semua';

  @override
  Widget build(BuildContext context) {
    final filteredGroups = transactionGroups.map((group) {
      final filteredTransactions = group['transactions'].where((t) {
        if (_selectedFilter == 'Semua') return true;
        if (_selectedFilter == 'Pemasukan') return t['type'] == 'masuk';
        if (_selectedFilter == 'Pengeluaran') return t['type'] == 'keluar';
        return false;
      }).toList();
      
      return {'date': group['date'], 'transactions': filteredTransactions};
    }).where((group) => group['transactions'].isNotEmpty).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Aktivitas", style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF8F9FA),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: kTextColor),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          const SizedBox(height: 16),
          _buildSummarySection(),
          const SizedBox(height: 24),
          _buildFilterChips(),
          const SizedBox(height: 24),
          const Text("Riwayat Transaksi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredGroups.length,
            itemBuilder: (context, index) {
              final group = filteredGroups[index];
              return _buildTransactionGroup(
                context,
                date: group['date'],
                transactions: group['transactions'],
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Row(
      children: [
        _buildSummaryCard("Pemasukan", "\$2,300.00", Icons.south_west_rounded, Colors.green),
        const SizedBox(width: 16),
        _buildSummaryCard("Pengeluaran", "\$1,650.50", Icons.north_east_rounded, Colors.red),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String amount, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(20), // DIPERBAIKI: withOpacity(0.08) -> withAlpha(20)
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(26), // DIPERBAIKI: withOpacity(0.1) -> withAlpha(26)
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kTextColor), overflow: TextOverflow.ellipsis),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildChip("Semua"),
        const SizedBox(width: 12),
        _buildChip("Pemasukan"),
        const SizedBox(width: 12),
        _buildChip("Pengeluaran"),
      ],
    );
  }

  Widget _buildChip(String label) {
    final bool isSelected = _selectedFilter == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = label;
          });
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
        side: BorderSide(color: kPrimaryColor.withAlpha(128)), // DIPERBAIKI: withOpacity(0.5) -> withAlpha(128)
      ),
      elevation: isSelected ? 3 : 0,
      pressElevation: 5,
    );
  }

  Widget _buildTransactionGroup(BuildContext context, {required String date, required List<dynamic> transactions}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
          child: Text(
            date,
            style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: transactions.map((tx) {
              final bool isLast = transactions.last == tx;
              return Column(
                children: [
                  TransactionListItem(
                    title: tx['title'],
                    date: '',
                    amount: (tx['amount'] as double),
                    icon: tx['type'] == 'masuk' ? Icons.arrow_downward : Icons.arrow_upward,
                    iconColor: tx['type'] == 'masuk' ? Colors.green : Colors.red, // Baris ini sekarang valid
                  ),
                  if (!isLast) const Divider(height: 1, indent: 20, endIndent: 20),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}