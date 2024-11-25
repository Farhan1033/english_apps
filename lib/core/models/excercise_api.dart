class ExcerciseApi {
  String? exerciseId;
  int? exerciseDuration;
  int? exerciseExp;
  int? exercisePoin;
  List<Quiz>? quiz;

  ExcerciseApi(
      {this.exerciseId,
      this.exerciseDuration,
      this.exerciseExp,
      this.exercisePoin,
      this.quiz});

  ExcerciseApi.fromJson(Map<String, dynamic> json) {
    exerciseId = json['exercise_id'];
    exerciseDuration = json['exercise_duration'];
    exerciseExp = json['exercise_exp'];
    exercisePoin = json['exercise_poin'];
    if (json['quiz'] != null) {
      quiz = <Quiz>[];
      json['quiz'].forEach((v) {
        quiz!.add(Quiz.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exercise_id'] = exerciseId;
    data['exercise_duration'] = exerciseDuration;
    data['exercise_exp'] = exerciseExp;
    data['exercise_poin'] = exercisePoin;
    if (quiz != null) {
      data['quiz'] = quiz!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quiz {
  String? question;
  List<String>? answer;
  int? correctAnswer;

  Quiz({this.question, this.answer, this.correctAnswer});

  Quiz.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'].cast<String>();
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    data['correct_answer'] = correctAnswer;
    return data;
  }
}
