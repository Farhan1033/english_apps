class TalkApi {
  bool? isCorrect;
  String? original;
  String? corrected;

  TalkApi({this.isCorrect, this.original, this.corrected});

  TalkApi.fromJson(Map<String, dynamic> json) {
    isCorrect = json['is_correct'];
    original = json['original'];
    corrected = json['corrected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_correct'] = isCorrect;
    data['original'] = original;
    data['corrected'] = corrected;
    return data;
  }
}