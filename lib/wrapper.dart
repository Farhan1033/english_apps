import 'package:apps_skripsi/features/Analysis/analysis_page.dart';
import 'package:apps_skripsi/features/Home/home_page.dart';
import 'package:apps_skripsi/features/Profile/profile_page.dart';
import 'package:apps_skripsi/features/Reward/reward_page.dart';
import 'package:apps_skripsi/features/Talk-AI/talk_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  List<Widget> listHalaman = [
    const HomePage(),
    const AnalysisPage(),
    const TalkPage(),
    const RewardPage(),
    const ProfilePage()
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _resetToHomePage();
  }

  /// Mengatur halaman awal ke HomePage setiap kali aplikasi dibuka
  Future<void> _resetToHomePage() async {
    setState(() {
      currentIndex = 0; // Tetapkan halaman pertama ke Home
    });
  }

  /// Menyimpan halaman terakhir (jika dibutuhkan di masa depan)
  Future<void> _saveLastPage(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastIndex', index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listHalaman[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          _saveLastPage(value); // Masih menyimpan jika dibutuhkan di masa depan
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics), label: 'Analysis'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Talk AI'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: 'Reward'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
