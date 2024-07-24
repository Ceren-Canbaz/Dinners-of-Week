import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class TeamUser extends Equatable {
  final String id;
  final String password;
  final String username;
  final bool? isAdmin;
  final String? salt;
  //change this prop with teamId
  final String? teamCode;

  const TeamUser({
    required this.password,
    required this.username,
    required this.id,
    this.isAdmin,
    this.salt,
    this.teamCode,
  });

  @override
  List<Object?> get props => [password, username, salt, teamCode];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'username': username,
      'salted': salt,
      'isAdmin': isAdmin,
      'teamsCode': teamCode
    };
  }

  factory TeamUser.fromMap(Map<String, dynamic> map) {
    return TeamUser(
        id: map['id'] as String,
        password: map['password'] as String,
        username: map['username'] as String,
        isAdmin: map['isAdmin'] as bool,
        salt: map['salted'] as String,
        teamCode: map['teamsCode'] ?? "");
  }

  TeamUser copyWith(
      {String? email,
      String? password,
      String? username,
      bool? isAdmin,
      String? salt,
      String? teamCode}) {
    return TeamUser(
        id: id,
        password: password ?? this.password,
        username: username ?? this.username,
        salt: salt ?? this.salt,
        isAdmin: isAdmin ?? this.isAdmin,
        teamCode: teamCode ?? this.teamCode);
  }
}
