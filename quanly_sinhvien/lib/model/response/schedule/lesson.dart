class Lesson {
  String lesson;
  String subjectName;
  String className;
  String address;

  Lesson({this.lesson, this.subjectName, this.address});

  Lesson.fromJson(Map<String, dynamic> json) {
    lesson = _lessonConvert(json['lessons']);
    subjectName = json['subject_name'];
    className= json['class_name'];
    address = json['address'];
    print('>> address: $address');
  }

  @override
  String toString() {
    return '$lesson@$subjectName@$className@$address';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lesson'] = this.lesson;
    data['subject_name'] = this.subjectName;
    data['address'] = this.address;
    return data;
  }

  String _lessonConvert(String lessonNumber) {
    // todo convert lesson string to time
    switch (lessonNumber) {
      case '1,2,3':
        return "1, 2, 3";
        break;
      case '4,5,5':
        return "4, 5, 6";
        break;
      case '7,8,9':
        return "7, 8, 9";
        break;
      case '10,11,12':
        return "10, 11, 12";
        break;
      case '13,14,15,16':
        return "13, 14, 15, 16";
        break;
      case '13,14,15':
        return "13, 14, 15";
        break;
      default:
        return "";
        break;
    }
  }
}