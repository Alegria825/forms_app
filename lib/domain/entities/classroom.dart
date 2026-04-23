class Classroom {
  final String id;
  final String subjectName;
  final String grade;
  final String group;
  final String professorId;
  final List<String> uidStudents;

  Classroom({
    required this.id,
    required this.subjectName,
    required this.grade,
    required this.group,
    required this.professorId,
    required this.uidStudents,
  });

  factory Classroom.fromFirestore(Map<String, dynamic> data, String id) {
    return Classroom(
      id: id,
      subjectName: data['subjectName'] ?? '',
      grade: data['grade'] ?? '',
      group: data['group'] ?? '',
      professorId: data['professorId'] ?? '',
      // Convertimos la lista dinámica de Firebase a una lista de Strings
      uidStudents: List<String>.from(data['uid_students'] ?? []),
    );
  }
}
