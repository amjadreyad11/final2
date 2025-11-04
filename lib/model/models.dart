class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String career;
  final String location;
  final String experience;
  final String? image;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.career,
    required this.location,
    required this.experience,
    this.image,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      career: map['career'] ?? '',
      location: map['location'] ?? '',
      experience: map['experience'] ?? '',
      image: map['image'],
    );
  }
}
