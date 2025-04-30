// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_rick_and_morty_characters/core/data/models/base_entity_filter.dart';

class CharacterFilter extends BaseEntityFilter {
  final String status;
  final String gender;
  final String type;
  final String species;

  CharacterFilter({
    required super.name,
    required this.status,
    required this.gender,
    required this.type,
    required this.species,
  });

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'status': status,
    'species': species,
    'gender': gender,
    'type': type,
  }..removeWhere((_, v) => (v as String).isEmpty);
}
