// lib/screens/services/game_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final games = [
      {'name': 'Mobile Legends', 'logo': 'ml.png'},
      {'name': 'PUBG Mobile', 'logo': 'pubg.png'},
      {'name': 'Free Fire', 'logo': 'ff.png'},
      {'name': 'Genshin Impact', 'logo': 'genshin.png'},
      {'name': 'Valorant', 'logo': 'valorant.png'},
      {'name': 'Steam Wallet', 'logo': 'steam.png'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Voucher Game', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.shade200,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari game favoritmu...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 24),
          const Text("Game Populer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: games.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final game = games[index];
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      // Ganti dengan Image.asset jika logo ada
                      child: const Center(child: Icon(Icons.gamepad_outlined, size: 40, color: kPrimaryColor)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(game['name']!, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
