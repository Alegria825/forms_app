class User {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String? enrollment;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.enrollment,
  });
}
