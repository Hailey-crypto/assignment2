import 'dart:io';

// 1. Score와 StudentScore 클래스를 구성하기 ⚪️
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

  void saveInfo() {
    File result = File('result.txt');
    result.writeAsStringSync('이름: $name, 점수: $score');
  }
}

List<String> names = [];
List<int> scores = [];
List<StudentScore> objects = [];

void main() {
  // 2. 파일로부터 데이터 읽어오기 기능 ⚪️
  File students = File('students.txt');
  List<String> lines = students.readAsLinesSync();

  for (int i = 0; i < lines.length; i++) {
    List<String> split = lines[i].split(',');
    String name = split[0];
    int score = int.parse(split[1]);
    StudentScore object = StudentScore(name, score);

    names.add(name);
    scores.add(score);
    objects.add(object);
  }

  // 3. 사용자로부터 입력 받아 학생 점수 확인 기능 ⚪️
  while (true) {
    print('> 어떤 학생의 점수를 확인하시겠습니까?');
    String? input = stdin.readLineSync();

    try {
      StudentScore found = objects.firstWhere(
        (student) => student.name == input,
      );
      found.showInfo();

      // 4. 프로그램 종료 후, 결과를 파일에 저장하는 기능 ⚪️
      try {
        found.saveInfo();
        print('저장이 완료되었습니다.');
      } catch (e) {
        print("저장에 실패했습니다: $e");
      }

      break;
    } catch (e) {
      print('잘못된 학생 이름을 입력하셨습니다. 다시 입력해주세요.');
    }
  }

  // 도전 문제
  while (true) {
    print(
      '\n > 메뉴를 선택하세요 : \n 1. 우수생 출력 \n 2. 전체 평균 점수 출력 \n 3. 전체 등수 출력 \n 4. 종료',
    );
    String? menu = stdin.readLineSync();

    switch (menu) {
      case '1':
        // 5-1. 학생들 중 우수생을 출력하는 기능 ⚪️
        int index = scores.indexOf(scores.reduce((a, b) => a > b ? a : b));
        String bestName = names[index];
        int bestScore = scores[index];
        print('우수생: $bestName (점수: $bestScore)');
      case '2':
        // 5-2. 전체 평균 점수를 출력하는 기능 ⚪️
        int sum = scores.reduce((a, b) => a + b);
        double average = sum / scores.length;
        String average2 = average.toStringAsFixed(2);
        print('전체 평균 점수: $average2');
      case '3':
        // 5-3. 전체 등수를 출력하는 기능 (나만의 추가 기능 구현) ⚪️
        for (int i = 1; i < objects.length + 1; i++) {
          int index = scores.indexOf(scores.reduce((a, b) => a > b ? a : b));
          String bestName = names[index];
          int bestScore = scores[index];
          print('$i등: $bestName (점수: $bestScore)');
          names.remove(bestName);
          scores.remove(bestScore);
        }
      case '4':
        print('프로그램을 종료합니다.');
        return;
      default:
        print('잘못된 숫자를 입력하셨습니다. 다시 입력해주세요.');
    }
  }
}
