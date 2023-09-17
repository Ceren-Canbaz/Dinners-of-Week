// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Auth {
  final String email;

  final String password;
  final String username;

  Auth({required this.email, required this.password, required this.username});

  @override
  List<Object?> get props => [email, password, username];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'username': username,
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      email: map['email'] as String,
      password: map['password'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) =>
      Auth.fromMap(json.decode(source) as Map<String, dynamic>);
}
