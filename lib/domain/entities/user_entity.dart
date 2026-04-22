class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String? enrollment;

  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.enrollment,
  });

  UserEntity copyWith({
    String? name,
    String? enrollment,
  }) {
    return UserEntity(
      uid: uid,
      email: email,
      role: role,
      name: name ?? this.name,
      enrollment: enrollment ?? this.enrollment,
    );
  }
}
