import 'package:apps_skripsi/features/Analysis/analysis_page.dart';
import 'package:apps_skripsi/features/Home/home_page.dart';
import 'package:apps_skripsi/features/Talk-AI/talk_page.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  List<Widget> listHalaman = [
    const HomePage(),
    const AnalysisPage(),
    const TalkPage()
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listHalaman[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
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
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}
