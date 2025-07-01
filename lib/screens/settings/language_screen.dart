// lib/screens/settings/language_screen.dart

import 'package:flutter/material.dart';
import 'package:dompetku/main.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'Indonesia';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // Daftar bahasa yang jauh lebih lengkap
  final List<Map<String, String>> _languages = [
    {'name': 'Afrikaans', 'native': 'Afrikaans'},
    {'name': 'Shqip', 'native': 'Albanian'},
    {'name': 'አማርኛ', 'native': 'Amharic'},
    {'name': 'العربية', 'native': 'Arabic'},
    {'name': 'Հայերեն', 'native': 'Armenian'},
    {'name': 'Azərbaycanca', 'native': 'Azerbaijani'},
    {'name': 'Euskara', 'native': 'Basque'},
    {'name': 'Беларуская', 'native': 'Belarusian'},
    {'name': 'বাংলা', 'native': 'Bengali'},
    {'name': 'Bosanski', 'native': 'Bosnian'},
    {'name': 'Български', 'native': 'Bulgarian'},
    {'name': 'Català', 'native': 'Catalan'},
    {'name': 'Cebuano', 'native': 'Cebuano'},
    {'name': 'Chichewa', 'native': 'Chichewa'},
    {'name': '中文 (简体)', 'native': 'Chinese (Simplified)'},
    {'name': '中文 (繁體)', 'native': 'Chinese (Traditional)'},
    {'name': 'Corsu', 'native': 'Corsican'},
    {'name': 'Hrvatski', 'native': 'Croatian'},
    {'name': 'Čeština', 'native': 'Czech'},
    {'name': 'Dansk', 'native': 'Danish'},
    {'name': 'Nederlands', 'native': 'Dutch'},
    {'name': 'English (US)', 'native': 'English (US)'},
    {'name': 'English (UK)', 'native': 'English (UK)'},
    {'name': 'Esperanto', 'native': 'Esperanto'},
    {'name': 'Eesti', 'native': 'Estonian'},
    {'name': 'Filipino', 'native': 'Filipino'},
    {'name': 'Suomi', 'native': 'Finnish'},
    {'name': 'Français', 'native': 'French'},
    {'name': 'Frysk', 'native': 'Frisian'},
    {'name': 'Galego', 'native': 'Galician'},
    {'name': 'ქართული', 'native': 'Georgian'},
    {'name': 'Deutsch', 'native': 'German'},
    {'name': 'Ελληνικά', 'native': 'Greek'},
    {'name': 'ગુજરાતી', 'native': 'Gujarati'},
    {'name': 'Kreyòl ayisyen', 'native': 'Haitian Creole'},
    {'name': 'Hausa', 'native': 'Hausa'},
    {'name': 'ʻŌlelo Hawaiʻi', 'native': 'Hawaiian'},
    {'name': 'עברית', 'native': 'Hebrew'},
    {'name': 'हिन्दी', 'native': 'Hindi'},
    {'name': 'Hmong', 'native': 'Hmong'},
    {'name': 'Magyar', 'native': 'Hungarian'},
    {'name': 'Íslenska', 'native': 'Icelandic'},
    {'name': 'Igbo', 'native': 'Igbo'},
    {'name': 'Indonesia', 'native': 'Bahasa Indonesia'},
    {'name': 'Gaeilge', 'native': 'Irish'},
    {'name': 'Italiano', 'native': 'Italian'},
    {'name': '日本語', 'native': 'Japanese'},
    {'name': 'Basa Jawa', 'native': 'Javanese'},
    {'name': 'ಕನ್ನಡ', 'native': 'Kannada'},
    {'name': 'Қазақ тілі', 'native': 'Kazakh'},
    {'name': 'ខ្មែរ', 'native': 'Khmer'},
    {'name': 'Kinyarwanda', 'native': 'Kinyarwanda'},
    {'name': '한국어', 'native': 'Korean'},
    {'name': 'Kurdî', 'native': 'Kurdish (Kurmanji)'},
    {'name': 'Кыргызча', 'native': 'Kyrgyz'},
    {'name': 'ພາສາລາວ', 'native': 'Lao'},
    {'name': 'Latviešu', 'native': 'Latvian'},
    {'name': 'Lietuvių', 'native': 'Lithuanian'},
    {'name': 'Lëtzebuergesch', 'native': 'Luxembourgish'},
    {'name': 'Македонски', 'native': 'Macedonian'},
    {'name': 'Malagasy', 'native': 'Malagasy'},
    {'name': 'Melayu', 'native': 'Bahasa Melayu'},
    {'name': 'മലയാളം', 'native': 'Malayalam'},
    {'name': 'Malti', 'native': 'Maltese'},
    {'name': 'Māori', 'native': 'Māori'},
    {'name': 'मराठी', 'native': 'Marathi'},
    {'name': 'Монгол', 'native': 'Mongolian'},
    {'name': 'မြန်မာ', 'native': 'Myanmar (Burmese)'},
    {'name': 'नेपाली', 'native': 'Nepali'},
    {'name': 'Norsk', 'native': 'Norwegian'},
    {'name': 'ଓଡିଆ', 'native': 'Odia (Oriya)'},
    {'name': 'ਪੰਜਾਬੀ', 'native': 'Punjabi'},
    {'name': 'فارسی', 'native': 'Persian'},
    {'name': 'Polski', 'native': 'Polish'},
    {'name': 'Português', 'native': 'Portuguese'},
    {'name': 'Română', 'native': 'Romanian'},
    {'name': 'Русский', 'native': 'Russian'},
    {'name': 'Samoa', 'native': 'Samoan'},
    {'name': 'Gàidhlig', 'native': 'Scots Gaelic'},
    {'name': 'Српски', 'native': 'Serbian'},
    {'name': 'Sesotho', 'native': 'Sesotho'},
    {'name': 'Shona', 'native': 'Shona'},
    {'name': 'سنڌي', 'native': 'Sindhi'},
    {'name': 'සිංහල', 'native': 'Sinhala'},
    {'name': 'Slovenčina', 'native': 'Slovak'},
    {'name': 'Slovenščina', 'native': 'Slovenian'},
    {'name': 'Soomaali', 'native': 'Somali'},
    {'name': 'Español', 'native': 'Spanish'},
    {'name': 'Basa Sunda', 'native': 'Sundanese'},
    {'name': 'Kiswahili', 'native': 'Swahili'},
    {'name': 'Svenska', 'native': 'Swedish'},
    {'name': 'Тоҷикӣ', 'native': 'Tajik'},
    {'name': 'தமிழ்', 'native': 'Tamil'},
    {'name': 'Татар', 'native': 'Tatar'},
    {'name': 'తెలుగు', 'native': 'Telugu'},
    {'name': 'ภาษาไทย', 'native': 'Thai'},
    {'name': 'Türkçe', 'native': 'Turkish'},
    {'name': 'Українська', 'native': 'Ukrainian'},
    {'name': 'اردو', 'native': 'Urdu'},
    {'name': 'O‘zbek', 'native': 'Uzbek'},
    {'name': 'Tiếng Việt', 'native': 'Vietnamese'},
    {'name': 'Cymraeg', 'native': 'Welsh'},
    {'name': 'isiXhosa', 'native': 'Xhosa'},
    {'name': 'ייִדיש', 'native': 'Yiddish'},
    {'name': 'Yorùbá', 'native': 'Yoruba'},
    {'name': 'isiZulu', 'native': 'Zulu'},
  ];

  @override
  void initState() {
    super.initState();
    // Mengurutkan daftar bahasa berdasarkan abjad
    _languages.sort((a, b) => a['name']!.compareTo(b['name']!));

    // Listener untuk text field pencarian
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Logika untuk memfilter bahasa berdasarkan query pencarian
    final filteredLanguages = _languages.where((lang) {
      final nameLower = lang['name']!.toLowerCase();
      final nativeLower = lang['native']!.toLowerCase();
      final searchLower = _searchQuery.toLowerCase();
      return nameLower.contains(searchLower) || nativeLower.contains(searchLower);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Pilih Bahasa", style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: kTextColor),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Widget untuk kolom pencarian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari bahasa...',
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),
          // Daftar bahasa yang bisa di-scroll
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredLanguages.length,
              itemBuilder: (context, index) {
                final language = filteredLanguages[index];
                final languageName = language['name']!;
                final nativeName = language['native']!;

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: _selectedLanguage == languageName
                        ? Border.all(color: kPrimaryColor, width: 1.5)
                        : Border.all(color: Colors.transparent),
                  ),
                  child: RadioListTile<String>(
                    title: Text(languageName),
                    subtitle: Text(nativeName, style: const TextStyle(color: Colors.grey)),
                    value: languageName,
                    groupValue: _selectedLanguage,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedLanguage = value;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Bahasa diubah ke $value')),
                        );
                      }
                    },
                    activeColor: kPrimaryColor,
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
