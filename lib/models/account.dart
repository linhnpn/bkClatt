class Account {
  int id;
  String username,
      role,
      fullname,
      gender,
      phone,
      email,
      profilePicture,
      location;
  DateTime dateOfBirth;

  Account({
    required this.id,
    required this.username,
    required this.role,
    required this.fullname,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.email,
    required this.profilePicture,
    required this.location,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      role: json['role'],
      username: json['username'],
      fullname: json['fullname'],
      gender: json['gender'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      phone: json['phone'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'role': role,
      'fullname': fullname,
      'gender': gender,
      'phone': phone,
      'email': email,
      'profilePicture': profilePicture,
      'location': location,
      'dateOfBirth': dateOfBirth.toIso8601String(),
    };
  }
}
