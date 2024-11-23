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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['fix'] = this.fix;
    data['is_correct'] = this.isCorrect;
    return data;
  }
}
