import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/text_filed.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/features/Check%20Grammar/check_grammar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckGrammarPage extends StatelessWidget {
  const CheckGrammarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.primary3,
        title:
            Tipografi().S1(isiText: 'Check Grammar', warnaFont: Warna.primary1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Consumer<CheckGrammarProvider>(
          builder: (context, checkGrammarProvider, child) {
            final grammar = checkGrammarProvider.talkApi!;
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      if (checkGrammarProvider.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (checkGrammarProvider.hasError != null) {
                        return const Center(
                          child: Text('Database not found!'),
                        );
                      }
                      if (checkGrammarProvider.talkApi == null) {
                        return const Center(
                          child: Text('Data not found!'),
                        );
                      }
                      return messageBox(context, grammar.corrected!,
                          CrossAxisAlignment.start, 'Gen-AI');
                    },
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: AreaTeks().teksCheck(
                              editingController:
                                  checkGrammarProvider.sentenceController,
                              textIsi: 'Check Grammar',
                              radius: BorderRadius.circular(8))),
                      _buildCircleButton(
                        context: context,
                        icon: Icons.send_rounded,
                        size: 20,
                        tinggi: 0.15,
                        lebar: 0.15,
                        onPressed: () {
                          checkGrammarProvider.checkGrammar(
                              checkGrammarProvider.sentenceController.text);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCircleButton(
      {required IconData icon,
      required double size,
      required VoidCallback onPressed,
      required double tinggi,
      required double lebar,
      required BuildContext context}) {
    return Container(
      width: MediaQuery.of(context).size.width * lebar,
      height: MediaQuery.of(context).size.width * tinggi,
      decoration: const BoxDecoration(
        color: Warna.primary3,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, size: size, color: Warna.primary1),
        onPressed: onPressed,
      ),
    );
  }

  Widget messageBox(BuildContext context, String chat, CrossAxisAlignment align,
      String person) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Warna.primary1,
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            offset: const Offset(0, 2),
            spreadRadius: 0.0,
            color: Warna.netral1.withOpacity(0.07),
          ),
          BoxShadow(
            blurRadius: 1.0,
            offset: const Offset(0, 3),
            spreadRadius: 0.0,
            color: Warna.netral1.withOpacity(0.06),
          ),
          BoxShadow(
            blurRadius: 10.0,
            offset: const Offset(0, 1),
            spreadRadius: 0.0,
            color: Warna.netral1.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Tipografi().S1(isiText: person, warnaFont: Warna.netral1),
          Tipografi().B2(isiText: chat, warnaFont: Warna.netral1),
        ],
      ),
    );
  }
}
