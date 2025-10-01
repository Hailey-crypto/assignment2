import 'dart:io';

// 1️⃣ Score와 StudentScore 클래스를 구성하기
class Score {
  int score;

  Score(this.score);

  void showInfo() {
    print('점수: $score');
  }
}

class StudentScore extends Score {
  String name;

  StudentScore(this.name, super.score);

  @override
  void showInfo() {
    print('이름: $name, 점수: $score');
  }

  void saveInfo() {
    File result = File('result.txt');
    result.writeAsStringSync('이름: $name, 점수: $score');
  }
}

void main() {
  // 2️⃣ 파일로부터 데이터 읽어오기 기능
  File students = File('students.txt');
  List<String> lines = students.readAsLinesSync();

  List<StudentScore> objects = [];
  List<String> names = [];

  for (int i = 0; i < lines.length; i++) {
    List<String> split = lines[i].split(',');
    String name = split[0];
    int score = int.parse(split[1]);
    StudentScore object = StudentScore(name, score);

    objects.add(object);
    names.add(name);
  }

  // 3️⃣ 사용자로부터 입력 받아 학생 점수 확인 기능
  print('어떤 학생의 점수를 확인하시겠습니까?');

  while (true) {
    String? input = stdin.readLineSync();

    try {
      StudentScore found = objects.firstWhere(
        (student) => student.name == input,
      );
      found.showInfo();

      // 4️⃣ 프로그램 종료 후, 결과를 파일에 저장하는 기능
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
}
