class UserModel {
  final String? id;
  final String username;
  final String first_name;
  final String last_name;
  final String mobileno;
  final String email;
  final String password;

  const UserModel({
    this.id,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.mobileno,
    required this.email,
    required this.password,
  });

  toJson() {
    return {
      "Username": username,
      "First_name": first_name,
      "Last_name": last_name,
      "Mobileno": mobileno,
      "Email": email,
      "Password": password,
    };
  }
}
