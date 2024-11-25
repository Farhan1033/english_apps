import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/features/Talk-AI/talk_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TalkPage extends StatefulWidget {
  const TalkPage({super.key});

  @override
  State<TalkPage> createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String _resultAiWord = '';

  @override
  void initState() {
    super.initState();
    _initializeSpeechToText();
  }

  Future<void> _initializeSpeechToText() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _sendDataAI() async {
    if (_lastWords.isEmpty) return;

    final talkAiProvider = Provider.of<TalkProvider>(context, listen: false);
    await talkAiProvider.talkAiGen(_lastWords);

    setState(() {
      _resultAiWord = talkAiProvider.talkAiApi!.answer!;
    });
  }

  void _startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() {});
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      if (result.finalResult) {
        _sendDataAI();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Warna.primary3,
          iconTheme: const IconThemeData(color: Warna.primary1),
          title: Tipografi()
              .S1(isiText: 'Talk With AI', warnaFont: Warna.primary1),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Column(
            children: [
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final talk = context.read<TalkProvider>();
                  if (index == 0) {
                    if (talk.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return messageBox(context, _resultAiWord,
                        CrossAxisAlignment.start, 'Gen-AI');
                  } else if (index == 1) {
                    return messageBox(
                        context, _lastWords, CrossAxisAlignment.end, 'Me');
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildCircleButton(
                    icon: Icons.restart_alt,
                    size: 25,
                    tinggi: 0.15,
                    lebar: 0.15,
                    onPressed: () {
                      setState(() {
                        _lastWords = '';
                        _resultAiWord = '';
                      });
                    },
                  ),
                  _buildCircleButton(
                    icon: _speechToText.isNotListening
                        ? Icons.mic_off
                        : Icons.mic,
                    size: 25,
                    tinggi: 0.15,
                    lebar: 0.15,
                    onPressed: _speechToText.isNotListening
                        ? _startListening
                        : _stopListening,
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildCircleButton({
    required IconData icon,
    required double size,
    required VoidCallback onPressed,
    required double tinggi,
    required double lebar,
  }) {
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
      margin: const EdgeInsets.only(bottom: 15),
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
