import 'package:flutter/material.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Auth {
  final String email;

  final String password;
  final String username;
  final String salt;

  Auth(
      {required this.email,
      required this.password,
      required this.username,
      required this.salt});

  @override
  List<Object?> get props => [email, password, username];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'username': username,
      'salted': salt
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
        email: map['email'] as String,
        password: map['password'] as String,
        username: map['username'] as String,
        salt: map['salt'] as String);
  }

  factory Auth.fromJson(String source) =>
      Auth.fromMap(json.decode(source) as Map<String, dynamic>);
  Auth copyWith(
      {String? email, String? password, String? username, String? salt}) {
    return Auth(
        email: email ?? this.email,
        password: password ?? this.password,
        username: username ?? this.username,
        salt: salt ?? this.salt);
  }
}
