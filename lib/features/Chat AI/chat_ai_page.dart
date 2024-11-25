import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/text_filed.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_ai_provider.dart';

class ChatAiPage extends StatelessWidget {
  const ChatAiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatAiProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Warna.primary3,
          iconTheme: IconThemeData(color: Warna.primary1),
          title: Tipografi()
              .S1(isiText: 'Chat With AI', warnaFont: Warna.primary1),
        ),
        body: Consumer<ChatAiProvider>(
          builder: (context, chatAiProvider, _) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: chatAiProvider.messages.length,
                      itemBuilder: (context, index) {
                        final message = chatAiProvider.messages[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Bubble(
                            alignment: message.isUserMessage
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            nip: message.isUserMessage
                                ? BubbleNip.rightBottom
                                : BubbleNip.leftBottom,
                            color: message.isUserMessage
                                ? Warna.primary3
                                : Warna.primary4,
                            child: Tipografi().B2(
                              isiText: message.text,
                              warnaFont: Warna.primary1,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: AreaTeks().teksCheck(
                          editingController: chatAiProvider.userChatController,
                          textIsi: 'Type Your Sentences here',
                          radius: BorderRadius.circular(8),
                        ),
                      ),
                      _buildCircleButton(
                        context: context,
                        icon: Icons.send_rounded,
                        size: 20,
                        tinggi: 0.15,
                        lebar: 0.15,
                        onPressed: () {
                          final sentence =
                              chatAiProvider.userChatController.text;

                          chatAiProvider.userChatController.clear();
                          chatAiProvider.chatAI(sentence);
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

  Widget _buildCircleButton({
    required IconData icon,
    required double size,
    required VoidCallback onPressed,
    required double tinggi,
    required double lebar,
    required BuildContext context,
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
}
