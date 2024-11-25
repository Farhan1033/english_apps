import 'package:apps_skripsi/core/models/talk_api.dart';
import 'package:apps_skripsi/core/service/talk_models.dart';
import 'package:flutter/material.dart';

class CheckGrammarProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _hasError;
  TalkApi? _talkApi;
  final TalkModels _talkModels = TalkModels();
  final TextEditingController _sentenceController = TextEditingController();

  bool get isLoading => _isLoading;
  String? get hasError => _hasError;
  TalkApi? get talkApi => _talkApi;
  TextEditingController get sentenceController => _sentenceController;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _hasError = value;
    notifyListeners();
  }

  void setTalkApi(TalkApi? value) {
    _talkApi = value;
    notifyListeners();
  }

  void setSentenceController(String value) {
    _sentenceController.text = value;
    notifyListeners();
  }

  Future<void> checkGrammar(String sentences) async {
    setLoading(true);
    setError(null);

    try {
      final checkData = await _talkModels.talkModels(sentences);

      if (checkData != null) {
        setTalkApi(checkData);
      } else {
        setTalkApi(null);
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void cleanData() {
    _sentenceController.dispose();
    _talkApi = null;
    _hasError = null;
    notifyListeners();
  }
}
