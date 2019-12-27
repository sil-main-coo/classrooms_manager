class Classroom{
  String id;
  String subjectName;
  String className;

  Classroom({this.id, this.subjectName, this.className});

  Classroom.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    subjectName = json['subject_name'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['subject_name'] = this.subjectName;
    data['class_name'] = this.className;
    return data;
  }
}