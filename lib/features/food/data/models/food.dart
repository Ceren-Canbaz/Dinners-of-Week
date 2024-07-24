// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class Food {
  final String id;
  final String name;
  final String description;
  final bool hasDrink;
  final String imageUrl;

  Food({
    required this.name,
    required this.hasDrink,
    required this.description,
    required this.id,
    required this.imageUrl,
  });

  Food copyWith({
    String? id,
    String? name,
    String? description,
    bool? hasDrink,
    String? imageUrl,
  }) {
    return Food(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      hasDrink: hasDrink ?? this.hasDrink,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'hasDrink': hasDrink,
      'imageUrl': imageUrl,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      hasDrink: map['hasDrink'] as bool,
      imageUrl: map['imageUrl'] as String,
    );
  }
  @override
  String toString() {
    return 'Food{id: $id, name: $name, description: $description, hasDrink: $hasDrink image: $imageUrl}';
  }
}
