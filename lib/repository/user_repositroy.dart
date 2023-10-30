import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dinners_of_week/main.dart';
import 'package:dinners_of_week/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStateException implements Exception {
  final String message;
  final String title;

  AuthStateException({required this.message, required this.title});
}

class UserRepositroy {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> signUp(Auth auth) async {
    try {
      print(auth);
      final salt = generateSalt();
      final hashedPassword = hashPassword(auth.password, salt);

      auth = auth.copyWith(password: hashedPassword, salt: salt);

      await supabase.from("users").insert(auth.toMap());

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('dowUsername', auth.username);
    } catch (e) {
      print("errorrrr $e");
      throw const PostgrestException(message: 'User already exist');
    }
  }

  Future<Auth> getUser(String username) async {
    try {
      final response = await supabase
          .from('users') // Tablo adını buraya ekleyin
          .select()
          .eq('username', username); // 'email' sütunu ile eşleşen verileri al
      final data = response as List<dynamic>;
      final user = Auth.fromMap(data.first);

      return user;
    } catch (e) {
      throw Exception();
    }
  }

  Future<bool> signIn(Auth auth) async {
    try {
      final user = await getUser(auth.username);
      if (user != null) {
        final pass = hashPassword(auth.password, user.salt!);

        if (user.password == pass) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('dowUsername', auth.username);
          return true;
        } else {
          throw AuthStateException(
              message: "Password or username incorrect",
              title: "Password Failure");
        }
      } else {
        throw AuthStateException(
            message: "Username doesnt exist", title: "Username Failure");
      }
    } catch (e) {
      rethrow;
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

  return response.toString();
}
