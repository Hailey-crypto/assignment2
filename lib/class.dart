import 'dart:io';

// 1. Score와 StudentScore 클래스를 구성하기 (객체 지향 활용) ⚪️
class Score {
  int score;

  Score(this.score);

  void showInfo() => print('점수: $score');
}

class StudentScore extends Score {
  String name;

  StudentScore(this.name, super.score);

  @override
  void showInfo() => print('이름: $name, 점수: $score');

  void saveInfo(String path) {
    File result = File(path);
    result.writeAsStringSync('이름: $name, 점수: $score');
  }
}
