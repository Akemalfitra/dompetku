import 'package:dompetku/main.dart';
import 'package:dompetku/screens/tabs/home_tab.dart';
import 'package:dompetku/screens/tabs/activities_tab.dart';
import 'package:dompetku/screens/tabs/wallet_tab.dart';
import 'package:dompetku/screens/tabs/settings_tab.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeTab(),
    const ActivitiesTab(),
    const Center(),
    const WalletTab(),
    const SettingsTab(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, '/add_card');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Beranda'),
          const BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Aktivitas'),
          BottomNavigationBarItem(
            icon: Container(
              decoration: const BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.add, color: Colors.white)),
            ),
            label: 'Tambah',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Dompet'),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Pengaturan'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}