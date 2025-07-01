import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data untuk setiap halaman onboarding
  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/onboarding1.png",
      "title": "Aplikasi Pembayaran Terdepan",
      "text": "Lebih dari 100 juta pengguna dengan ribuan mitra dan layanan di seluruh dunia."
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Gengsi dan Keamanan Absolut",
      "text": "Berlisensi oleh semua bank di dunia & diamankan dengan standar internasional multi-lapis PCI-DSS."
    },
    {
      "image": "assets/images/onboarding3.png",
      "title": "Dapatkan Penawaran Menarik Seketika",
      "text": "Daftar sekarang untuk menerima paket hadiah besar. Makan, nonton film & banyak layanan lainnya."
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  // Langsung ke halaman login dan hapus halaman onboarding dari tumpukan
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Lewati'),
              ),
            ),
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) => OnboardingContent(
                  image: _onboardingData[index]["image"]!,
                  title: _onboardingData[index]["title"]!,
                  text: _onboardingData[index]["text"]!,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    // Indikator titik
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingData.length,
                        (index) => _buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    // Tombol Aksi (Next/Selesai)
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          // Jika bukan halaman terakhir, pindah ke halaman berikutnya
                          if (_currentPage < _onboardingData.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          } else {
                            // Jika halaman terakhir, navigasi ke halaman login
                             Navigator.pushReplacementNamed(context, '/login');
                          }
                        },
                        // Ganti ikon berdasarkan halaman saat ini
                        child: Icon(
                          _currentPage == _onboardingData.length - 1
                              ? Icons.check
                              : Icons.arrow_forward,
                          size: 28,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat indikator titik (dot)
  AnimatedContainer _buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

// Widget terpisah untuk konten setiap halaman onboarding
class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.text,
  });

  final String image, title, text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          Image.asset(
            image,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          const Spacer(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: kSubtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}