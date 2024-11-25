class TalkAiApi {
  String? answer;
  String? fix;
  bool? isCorrect;

  TalkAiApi({this.answer, this.fix, this.isCorrect});

  TalkAiApi.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    fix = json['fix'];
    isCorrect = json['is_correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer'] = answer;
    data['fix'] = fix;
    data['is_correct'] = isCorrect;
    return data;
  }
}
