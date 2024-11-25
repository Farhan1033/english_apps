import 'package:apps_skripsi/core/models/talk_ai_api.dart';
import 'package:apps_skripsi/core/service/talk_ai_models.dart';
import 'package:apps_skripsi/core/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class ChatAiProvider with ChangeNotifier {
  TalkAiApi? _talkAiApi;
  bool _isLoading = false;
  String? _resultChat;
  final TalkAiModels _talkAiModels = TalkAiModels();
  final TextEditingController _userChatController = TextEditingController();

  List<Message> _messages = [];

  List<Message> get messages => _messages;

  TalkAiApi? get talkApi => _talkAiApi;
  bool get isLoading => _isLoading;
  String? get resultChat => _resultChat;
  TextEditingController get userChatController => _userChatController;

  void setController(String value) {
    _userChatController.text = value;
    notifyListeners();
  }

  void setloading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setTalkAiApi(TalkAiApi? value) {
    _talkAiApi = value;
    notifyListeners();
  }

  void setResult(String? value) {
    _resultChat = value;
    notifyListeners();
  }

  void addMessage(String text, bool isUserMessage) {
    _messages.add(Message(text: text, isUserMessage: isUserMessage));
    notifyListeners();
  }

  Future<void> chatAI(String sentence) async {
    addMessage(sentence, true);

    setloading(true);

    final token = await Token().getToken();
    final chatAiData = await _talkAiModels.talkAiModels(token ?? '', sentence);
    if (chatAiData != null) {
      setTalkAiApi(chatAiData);
      setResult(chatAiData.answer);
      addMessage(chatAiData.answer ?? 'No response from AI', false);
    } else {
      setTalkAiApi(null);
      addMessage('Error communicating with the AI.', false);
    }

    setloading(false);
  }

  void cleanData() {
    _messages.clear();
    _resultChat = null;
    _talkAiApi = null;
    _userChatController.clear();
    notifyListeners();
  }
}

class Message {
  final String text;
  final bool isUserMessage;

  Message({required this.text, required this.isUserMessage});
}
