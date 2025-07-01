import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({super.key});

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  final List<Map<String, dynamic>> savedCards = [
    {
      'cardNumber': '5450 7879 4564 3728',
      'expiryDate': '02/26',
      'cardHolderName': 'Andre',
      'cvvCode': '123',
      'cardType': CardType.mastercard,
    },
    {
      'cardNumber': '4242 4242 4242 3456',
      'expiryDate': '08/25',
      'cardHolderName': 'Andre',
      'cvvCode': '456',
      'cardType': CardType.visa,
    },
  ];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92); // Sedikit disesuaikan
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  BoxDecoration _getCardStyling(CardType cardType) {
    switch (cardType) {
      case CardType.visa:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1a1e6c), Color(0xFF2652a1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
      case CardType.mastercard:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF222222), Color(0xFF444444)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
      default:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryColor, const Color(0xff00695c)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          // --- BAGIAN KARTU DIPINDAHKAN KE ATAS ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Kartu Terhubung", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
                TextButton(onPressed: (){}, child: const Text("Kelola"))
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCardCarousel(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildAddNewCardButton(context),
          ),
          const SizedBox(height: 24),

          // --- BAGIAN AKSI ---
          _buildActionPanel(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Dompet Saya", style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined, color: Colors.grey),
        )
      ],
    );
  }

  Widget _buildActionPanel(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildServiceIcon(context, Icons.swap_horiz_rounded, 'Kirim Uang', () {}),
          _buildServiceIcon(context, Icons.add_card_rounded, 'Isi Saldo', () {
            Navigator.pushNamed(context, '/deposit');
          }),
          _buildServiceIcon(context, Icons.history_rounded, 'Aktivitas', () {}),
        ],
      ),
    );
  }
  
  Widget _buildServiceIcon(BuildContext context, IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: kPrimaryColor.withAlpha(26),
            child: Icon(icon, color: kPrimaryColor, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: kTextColor.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCardCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 200, // Sedikit disesuaikan tingginya
          child: PageView.builder(
            controller: _pageController,
            itemCount: savedCards.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final card = savedCards[index];
              final cardDecoration = _getCardStyling(card['cardType']);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  decoration: cardDecoration.copyWith(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: CreditCardWidget(
                    cardNumber: card['cardNumber'],
                    expiryDate: card['expiryDate'],
                    cardHolderName: card['cardHolderName'],
                    cvvCode: card['cvvCode'],
                    showBackView: false,
                    onCreditCardWidgetChange: (brand) {},
                    cardBgColor: Colors.transparent, 
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(savedCards.length, (index) => _buildPageIndicator(index)),
        ),
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
  
  Widget _buildAddNewCardButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, '/add_card');
      },
      icon: const Icon(Icons.add_rounded, color: kPrimaryColor),
      label: const Text("Tambah kartu baru", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(color: kPrimaryColor.withOpacity(0.5), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}