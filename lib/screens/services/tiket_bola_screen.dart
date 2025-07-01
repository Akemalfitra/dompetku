// lib/screens/services/tiket_bola_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class TiketBolaScreen extends StatefulWidget {
  // FIX: Menghapus 'const' dari constructor untuk membantu hot reload
  const TiketBolaScreen({super.key});

  @override
  State<TiketBolaScreen> createState() => _TiketBolaScreenState();
}

class _TiketBolaScreenState extends State<TiketBolaScreen> {
  // Data dummy yang lebih lengkap dengan region dan liga
  final List<Map<String, String>> _allMatches = const [
    // Asia
    {
      'home_team': 'Persija Jakarta', 'away_team': 'Persib Bandung', 'home_logo': '', 'away_logo': '',
      'region': 'Asia', 'league': 'Liga 1 Indonesia', 'date': '5 Juli 2025, 19:00 WIB', 'stadium': 'Gelora Bung Karno, Jakarta'
    },
    {
      'home_team': 'Arema FC', 'away_team': 'Persebaya Surabaya', 'home_logo': '', 'away_logo': '',
      'region': 'Asia', 'league': 'Liga 1 Indonesia', 'date': '6 Juli 2025, 15:30 WIB', 'stadium': 'Stadion Kanjuruhan, Malang'
    },
    {
      'home_team': 'Al-Nassr', 'away_team': 'Al-Hilal', 'home_logo': '', 'away_logo': '',
      'region': 'Asia', 'league': 'Saudi Pro League', 'date': '7 Juli 2025, 21:00 WIB', 'stadium': 'Mrsool Park, Riyadh'
    },
    // Eropa
    {
      'home_team': 'Manchester United', 'away_team': 'Liverpool', 'home_logo': '', 'away_logo': '',
      'region': 'Eropa', 'league': 'Premier League', 'date': '8 Juli 2025, 20:00 WIB', 'stadium': 'Old Trafford, Manchester'
    },
    {
      'home_team': 'Real Madrid', 'away_team': 'Barcelona', 'home_logo': '', 'away_logo': '',
      'region': 'Eropa', 'league': 'La Liga', 'date': '9 Juli 2025, 22:00 WIB', 'stadium': 'Santiago Bernabéu, Madrid'
    },
    {
      'home_team': 'Bayern Munich', 'away_team': 'Dortmund', 'home_logo': '', 'away_logo': '',
      'region': 'Eropa', 'league': 'Bundesliga', 'date': '10 Juli 2025, 19:30 WIB', 'stadium': 'Allianz Arena, Munich'
    },
    // Amerika
    {
      'home_team': 'Inter Miami', 'away_team': 'LA Galaxy', 'home_logo': '', 'away_logo': '',
      'region': 'Amerika', 'league': 'MLS', 'date': '11 Juli 2025, 07:00 WIB', 'stadium': 'DRV PNK Stadium, Miami'
    },
  ];

  // State untuk filter
  String _selectedRegion = 'Semua';
  String? _selectedLeague;
  List<Map<String, String>> _filteredMatches = [];

  @override
  void initState() {
    super.initState();
    _filterMatches();
  }

  void _filterMatches() {
    List<Map<String, String>> matches = [];
    if (_selectedRegion == 'Semua') {
      matches = List.from(_allMatches);
    } else {
      matches = _allMatches.where((m) => m['region'] == _selectedRegion).toList();
    }

    if (_selectedLeague != null) {
      matches = matches.where((m) => m['league'] == _selectedLeague).toList();
    }
    
    setState(() {
      _filteredMatches = matches;
    });
  }

  List<String> _getAvailableLeagues(String region) {
    if (region == 'Semua') return [];
    return _allMatches
        .where((m) => m['region'] == region)
        .map((m) => m['league']!)
        .toSet()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final availableLeagues = _getAvailableLeagues(_selectedRegion);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Tiket Bola', style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.shade200,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          _buildRegionFilter(),
          if (_selectedRegion != 'Semua' && availableLeagues.isNotEmpty)
            _buildLeagueFilter(availableLeagues),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Text(
              _selectedLeague ?? _selectedRegion,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildMatchList(),
        ],
      ),
    );
  }

  Widget _buildRegionFilter() {
    final regions = ['Semua', 'Asia', 'Eropa', 'Amerika'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: regions.length,
        itemBuilder: (context, index) {
          final region = regions[index];
          final isSelected = _selectedRegion == region;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(region),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedRegion = region;
                    _selectedLeague = null; // Reset filter liga saat region diganti
                  });
                  _filterMatches();
                }
              },
              labelStyle: TextStyle(color: isSelected ? Colors.white : kPrimaryColor, fontWeight: FontWeight.bold),
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

  Widget _buildLeagueFilter(List<String> leagues) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: leagues.length,
          itemBuilder: (context, index) {
            final league = leagues[index];
            final isSelected = _selectedLeague == league;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FilterChip(
                label: Text(league),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedLeague = isSelected ? null : league;
                  });
                   _filterMatches();
                },
                labelStyle: TextStyle(color: isSelected ? Colors.white : kTextColor),
                backgroundColor: Colors.white,
                selectedColor: kPrimaryColor.withOpacity(0.8),
                checkmarkColor: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMatchList() {
    if (_filteredMatches.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text("Tidak ada pertandingan yang tersedia.", style: TextStyle(color: Colors.grey)),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredMatches.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildMatchCard(context, _filteredMatches[index]);
      },
    );
  }

  Widget _buildMatchCard(BuildContext context, Map<String, String> match) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTeam(teamName: match['home_team']!, logoPath: match['home_logo']!),
                const Text("VS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryColor)),
                _buildTeam(teamName: match['away_team']!, logoPath: match['away_logo']!),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildMatchInfoRow(Icons.sports_soccer_outlined, match['league']!),
                const SizedBox(height: 8),
                _buildMatchInfoRow(Icons.calendar_today_outlined, match['date']!),
                const SizedBox(height: 8),
                _buildMatchInfoRow(Icons.location_on_outlined, match['stadium']!),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
              child: const Text("Beli Tiket"),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTeam({required String teamName, required String logoPath}) {
    return Column(
      children: [
        // Ganti dengan Image.asset jika logo tersedia
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade200,
          child: const Icon(Icons.shield, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            teamName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildMatchInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(color: Colors.grey))),
      ],
    );
  }
}
