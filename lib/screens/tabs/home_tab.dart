import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dompetku/main.dart'; // Mengambil kPrimaryColor & kTextColor dari main.dart

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;
  bool _isBalanceVisible = true;

  // Data untuk banner promo, tidak ada perubahan di sini
  final List<Map<String, dynamic>> promoData = [
    {
      'bgColor': const Color(0xff003d3d),
      'textColor': Colors.white,
      'smallTitle': "DISKON 30%",
      'bigTitle': "Promo Black Friday",
      'subtitle':
          "Dapatkan diskon untuk setiap isi ulang, transfer, dan pembayaran",
      'decorations': [
        Positioned(
            right: -40,
            bottom: -50,
            child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    color: Color(0xff4ce399), shape: BoxShape.circle))),
        Positioned(
            right: 20,
            bottom: 25,
            child: Text("30%",
                style: TextStyle(
                    color: const Color(0xff003d3d).withAlpha(150),
                    fontSize: 28,
                    fontWeight: FontWeight.bold))),
        Positioned(
            top: 15,
            right: 25,
            child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                    color: Colors.orangeAccent, shape: BoxShape.circle))),
      ]
    },
    {
      'bgColor': const Color(0xffffe6cc),
      'textColor': const Color(0xff333333),
      'smallTitle': "PENAWARAN SPESIAL",
      'bigTitle': "Isi Ulang Hari Ini",
      'subtitle':
          "Bonus saldo hingga 15% untuk setiap pengisian ulang di hari Rabu",
      'decorations': [
        Positioned(
            right: -20,
            top: -20,
            child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                    color: Color(0xff003d3d),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(120))))),
        Positioned(
            right: 50,
            bottom: 50,
            child: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                    color: Colors.orange, shape: BoxShape.circle))),
      ],
    },
    {
      'bgColor': const Color(0xff4a148c),
      'textColor': Colors.white,
      'smallTitle': "BAYAR TAGIHAN",
      'bigTitle': "Cashback Kilat",
      'subtitle':
          "Bayar tagihan listrik atau air dan dapatkan cashback instan Rp 10.000",
      'decorations': [
        Positioned(
            left: -30,
            top: -30,
            child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.purpleAccent.withAlpha(77),
                    shape: BoxShape.circle))),
        Positioned(
            right: 20,
            bottom: 20,
            child: Icon(Icons.receipt_long,
                color: Colors.white.withAlpha(77), size: 80)),
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (!mounted || !_pageController.hasClients) return;
      int nextPage = _pageController.page!.round() + 1;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Latar belakang lebih lembut
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildBalanceCard(),
            const SizedBox(height: 24),
            _buildMainActions(),
            const SizedBox(height: 32),
            _buildPaymentList(),
            const SizedBox(height: 32),
            _buildPromoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Halo,",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 2),
              Text("akem",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kTextColor)),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined,
                      color: Colors.grey, size: 28)),
              const SizedBox(width: 8),
              const CircleAvatar(
                backgroundColor: kPrimaryColor,
                child: Text("a",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [kPrimaryColor, Color(0xff00695c)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withAlpha(50),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Saldo Tersedia",
                  style: TextStyle(fontSize: 16, color: Colors.white70)),
              IconButton(
                onPressed: () =>
                    setState(() => _isBalanceVisible = !_isBalanceVisible),
                icon: Icon(
                  _isBalanceVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.white70,
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _isBalanceVisible ? "Rp 1.590.100" : "••••••••",
            style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildMainActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
              label: "Kirim",
              icon: Icons.swap_horiz_rounded,
              onTap: () => Navigator.pushNamed(context, '/transfer')),
          _buildActionButton(
              label: "Isi Ulang",
              icon: Icons.add_card_rounded,
              onTap: () => Navigator.pushNamed(context, '/deposit')),
          _buildActionButton(
              label: "Riwayat",
              icon: Icons.history_rounded,
              onTap: () => Navigator.pushNamed(context, '/payment_history')),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      {required String label,
      required IconData icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Icon(icon, color: kPrimaryColor, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(
                  color: kTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildPaymentList() {
    // --- DAFTAR DIPERBARUI DENGAN RUTE BARU ---
    final paymentItems = [
      {'label': 'Listrik', 'icon': Icons.flash_on_rounded, 'route': '/electric_bill'},
      {'label': 'Internet', 'icon': Icons.wifi_rounded, 'route': '/internet'},
      {'label': 'Voucher', 'icon': Icons.local_offer_rounded, 'route': '/voucher'},
      {'label': 'Asuransi', 'icon': Icons.shield_rounded, 'route': '/insurance'},
      {'label': 'Merchant', 'icon': Icons.store_rounded, 'route': '/merchant'},
      {'label': 'Pulsa', 'icon': Icons.phone_android_rounded, 'route': '/mobile_top_up'},
      {'label': 'Tagihan', 'icon': Icons.receipt_long_rounded, 'route': '/electric_bill'},
      {'label': 'Lainnya', 'icon': Icons.apps_rounded, 'route': '/services'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Daftar Pembayaran",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kTextColor)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: paymentItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 16, mainAxisSpacing: 16),
            itemBuilder: (context, index) {
              final item = paymentItems[index];
              return _buildPaymentIcon(
                  label: item['label'] as String,
                  icon: item['icon'] as IconData,
                  route: item['route'] as String?);
            },
          )
        ],
      ),
    );
  }

  Widget _buildPaymentIcon(
      {required String label, required IconData icon, String? route}) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Fitur $label segera hadir!'),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: kTextColor,
          ));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: kPrimaryColor.withAlpha(26),
            child: Icon(icon, color: kPrimaryColor, size: 28),
          ),
          const SizedBox(height: 8),
          Flexible(
              child: Text(label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: kTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _buildPromoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Promo & Diskon",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kTextColor)),
              TextButton(onPressed: () {}, child: const Text("Lihat Semua"))
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) =>
                setState(() => _currentPage = page % promoData.length),
            itemBuilder: (context, index) {
              final promo = promoData[index % promoData.length];
              double scale = _currentPage == (index % promoData.length) ? 1.0 : 0.9;
              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 350),
                tween: Tween(begin: scale, end: scale),
                curve: Curves.ease,
                child: _buildPromoCard(
                  bgColor: promo['bgColor'],
                  textColor: promo['textColor'],
                  smallTitle: promo['smallTitle'],
                  bigTitle: promo['bigTitle'],
                  subtitle: promo['subtitle'],
                  decorations: promo['decorations'],
                ),
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              List.generate(promoData.length, (index) => _buildPageIndicator(index)),
        )
      ],
    );
  }

  Widget _buildPageIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: _currentPage == index ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: _currentPage == index ? kPrimaryColor : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildPromoCard({
    required Color bgColor,
    required Color textColor,
    required String smallTitle,
    required String bigTitle,
    required String subtitle,
    required List<Widget> decorations,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          ...decorations,
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(smallTitle,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5)),
                const SizedBox(height: 4),
                Text(bigTitle,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(subtitle,
                    style: TextStyle(color: textColor.withAlpha(200), fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
