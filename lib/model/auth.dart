import 'package:flutter/material.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

class Auth {
  final String password;
  final String username;
  final String salt;

  Auth({required this.password, required this.username, required this.salt});

  @override
  List<Object?> get props => [password, username];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'username': username,
      'salted': salt
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
        password: map['password'] as String,
        username: map['username'] as String,
        salt: map['salted'] as String);
  }

  Auth copyWith(
      {String? email, String? password, String? username, String? salt}) {
    return Auth(
        password: password ?? this.password,
        username: username ?? this.username,
        salt: salt ?? this.salt);
  }
}
