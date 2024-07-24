import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dinners_of_week/main.dart';
import 'package:dinners_of_week/auth/data/models/team_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStateException implements Exception {
  final String message;
  final String title;

  AuthStateException({required this.message, required this.title});
}

class UserRepositroy {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<TeamUser> signUp(TeamUser user) async {
    try {
      final salt = generateSalt();
      final hashedPassword = hashPassword(user.password, salt);

      user = user.copyWith(password: hashedPassword, salt: salt);

      await supabase.from("users").insert(user.toMap());

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('dowUsername', user.username);
      return await getUser(user.username);
    } catch (e) {
      throw const PostgrestException(message: 'User already exist');
    }
  }

  Future<TeamUser> getUser(String username) async {
    try {
      final response = await supabase
          .from('users') // Tablo adını buraya ekleyin
          .select()
          .eq('username', username); // 'email' sütunu ile eşleşen verileri al
      final data = response as List<dynamic>;
      final user = TeamUser.fromMap(data.first);

      return user;
    } catch (e) {
      throw Exception();
    }
  }

  Future<bool> signIn(TeamUser user) async {
    try {
      final fetchedUser = await getUser(user.username);
      if (fetchedUser != null) {
        final pass = hashPassword(fetchedUser.password, fetchedUser.salt!);

        if (fetchedUser.password == pass) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('dowUsername', fetchedUser.username);
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
