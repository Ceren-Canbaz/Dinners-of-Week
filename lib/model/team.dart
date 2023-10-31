// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TeamModel extends Equatable {
  final String id;
  final String name;

  TeamModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamModel.fromJson(String source) =>
      TeamModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
