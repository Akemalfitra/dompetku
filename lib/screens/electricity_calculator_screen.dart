import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';
import 'package:fl_chart/fl_chart.dart';

class ElectricityCalculatorScreen extends StatelessWidget {
  const ElectricityCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Tagihan Listrik', style: TextStyle(color: kTextColor)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('6 Bulan Terakhir', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 50,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: _bottomTitles)),
                ),
                borderData: FlBorderData(show: false),
                barGroups: _barGroups(),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _buildSummaryCard('Pembayaran bulanan tertinggi', '\$55', Colors.red.shade100),
              const SizedBox(width: 16),
              _buildSummaryCard('Total konsumsi daya', '150 kWh', Colors.blue.shade100),
            ],
          )
        ],
      ),
    );
  }
  
  Widget _buildSummaryCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0: text = 'Mei'; break;
      case 1: text = 'Jun'; break;
      case 2: text = 'Jul'; break;
      case 3: text = 'Ags'; break;
      case 4: text = 'Sep'; break;
      case 5: text = 'Okt'; break;
      default: text = ''; break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, space: 4.0, child: Text(text, style: style));
  }

  List<BarChartGroupData> _barGroups() {
    return [
      _makeGroupData(0, 20), _makeGroupData(1, 35), _makeGroupData(2, 18),
      _makeGroupData(3, 40), _makeGroupData(4, 15), _makeGroupData(5, 48),
    ];
  }

  BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: kPrimaryColor.withAlpha(y > 45 ? 255 : 128),
          width: 15,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4))
        )
      ]
    );
  }
}