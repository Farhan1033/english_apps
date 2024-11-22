import 'package:apps_skripsi/core/models/talk_api.dart';
import 'package:apps_skripsi/core/service/talk_models.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TalkProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _speechEnabled = false;
  String? _lastWord;
  String? _errorMessage;
  TalkApi? _talkApi;
  final TalkModels _talkModels = TalkModels();
  SpeechToText speechToText = SpeechToText();
  TextEditingController controller = TextEditingController();

  bool get isLoading => _isLoading;
  bool get speechEnabled => _speechEnabled;
  String? get errorMessage => _errorMessage;
  String? get lastWord => _lastWord;
  TalkApi? get talkApi => _talkApi;

  void initSpeech() async {
    _speechEnabled = await speechToText.initialize();
    notifyListeners();
  }

  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    notifyListeners();
  }

  void stopListening() async {
    await speechToText.stop();
    notifyListeners();
  }

  Future <void> onSpeechResult(SpeechRecognitionResult result) async {
    _lastWord = result.recognizedWords;
    controller.text = _lastWord ?? '';

    if (result.finalResult) {

          notifyListeners();
      sendData();
    }

  }

  Future<void> sendData() async {
 

    await talkAI(_lastWord!);

  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  void setTalkApi(TalkApi? value) {
    _talkApi = value;
    notifyListeners();
  }

  Future<void> talkAI(String sentence) async {
    setLoading(true);
    setMessage(null);

    try {
      final talkAIData = await _talkModels.talkModels(sentence);
      print(_lastWord);
      if (talkAIData != null) {
        setTalkApi(talkAIData);
      }
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void cleanData() {
    setMessage(null);
    setTalkApi(null);
  }
}
