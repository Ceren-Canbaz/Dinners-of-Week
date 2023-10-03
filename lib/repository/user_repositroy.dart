import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dinners_of_week/main.dart';
import 'package:dinners_of_week/model/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthException implements Exception {
  final String message;
  final String title;

  AuthException({required this.message, required this.title});
}

class UserRepositroy {
  Future<void> signUp(Auth auth) async {
    try {
      final salt = generateSalt();
      final hashedPassword = hashPassword(auth.password, salt);

      auth = auth.copyWith(password: hashedPassword, salt: salt);

      await supabase.from("users").insert(auth.toMap());
    } catch (e) {
      throw PostgrestException(message: 'User already exist');
    }
  }
}

// abstract class Failure {
//   final String message;

//   Failure({required this.message});
// }

// class UserAlreadyExistFailure implements Failure {
//   @override
//   // TODO: implement message
//   String get message => ""
// }

String generateSalt() {
  final random = Random.secure();
  final saltBytes = List<int>.generate(16, (i) => random.nextInt(255));

  final salt = base64UrlEncode(saltBytes);
  return salt;
}

String hashPassword(String password, String salt) {
  final codec = Utf8Codec();
  final passwordBytes = codec.encode(password);
  final saltBytes = base64Url.decode(salt); // Buradaki decode'i kaldırın.

  final response = sha256.convert([...saltBytes, ...passwordBytes]);
  print("first response =$response");
  return response.toString();
}
