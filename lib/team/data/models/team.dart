import 'package:equatable/equatable.dart';

class TeamModel extends Equatable {
  final String id;
  final String name;
  final String code;
  const TeamModel({required this.id, required this.name, required this.code});

  @override
  List<Object?> get props => [id, name];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'code': code};
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
        id: map['id'] as String,
        name: map['name'] as String,
        code: map['code'] as String);
  }
}
