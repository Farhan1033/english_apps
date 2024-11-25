import 'package:apps_skripsi/core/models/talk_ai_api.dart';
import 'package:apps_skripsi/core/models/talk_api.dart';
import 'package:apps_skripsi/core/service/talk_ai_models.dart';
import 'package:apps_skripsi/core/service/talk_models.dart';
import 'package:apps_skripsi/core/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class TalkProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  TalkApi? _talkApi;
  TalkAiApi? _talkAiApi;
  final TalkAiModels _talkAiModels = TalkAiModels();
  final TalkModels _talkModels = TalkModels();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  TalkApi? get talkApi => _talkApi;
  TalkAiApi? get talkAiApi => _talkAiApi;

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

  void setTalkAiApi(TalkAiApi? value) {
    _talkAiApi = value;
    notifyListeners();
  }

  Future<void> talkAiGen(String sentence) async {
    setLoading(true);
    setMessage(null);

    try {
      final token = await Token().getToken();
      final talkAiGenData =
          await _talkAiModels.talkAiModels(token ?? '', sentence);

      if (talkAiGenData != null) {
        setTalkAiApi(talkAiGenData);
      }
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> talkAI(String sentence) async {
    setLoading(true);
    setMessage(null);

    try {
      final talkAIData = await _talkModels.talkModels(sentence);

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
