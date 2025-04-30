// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_rick_and_morty_characters/core/data/models/base_entity.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character_location.dart';

class Character extends BaseEntity {
  Character({
    required super.id,
    required super.name,
    required super.url,
    required super.created,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
  });
  final String status;
  final String species;
  final String type;
  final String gender;
  final CharacterLocation origin;
  final CharacterLocation location;
  final String image;
  final List<String> episode;

  List<int> get episodeIDs =>
      episode.map((e) => int.parse(e.split('/').last)).toList();
  int? get originLocationID => int.tryParse(origin.url.split('/').last);
  int? get lastLocationID => int.tryParse(location.url.split('/').last);

  factory Character.fromJson(Map<String, dynamic> json) => Character(
    id: json['id'] as int,
    name: json['name'] as String,
    status: json['status'] as String,
    species: json['species'] as String,
    type: json['type'] as String,
    gender: json['gender'] as String,
    origin: CharacterLocation.fromJson(json['origin']),
    location: CharacterLocation.fromJson(json['location']),
    image: json['image'] as String,
    episode: (json['episode'] as List).map((e) => e as String).toList(),
    url: json['url'] as String,
    created: DateTime.parse(json['created'] as String),
  );
  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'type': type,
    'gender': gender,
    'origin': origin.toJson(),
    'location': location.toJson(),
    'image': image,
    'episode': episode,
    'url': url,
    'created': created.toIso8601String(),
  };

  @override
  bool operator ==(covariant Character other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.species == species &&
        other.type == type &&
        other.gender == gender &&
        other.origin == origin &&
        other.location == location &&
        other.image == image &&
        listEquals(other.episode, episode);
  }

  @override
  int get hashCode {
    return status.hashCode ^
        species.hashCode ^
        type.hashCode ^
        gender.hashCode ^
        origin.hashCode ^
        location.hashCode ^
        image.hashCode ^
        episode.hashCode;
  }

  @override
  String toString() {
    return 'Character(status: $status, species: $species, type: $type, gender: $gender, origin: $origin, location: $location, image: $image, episode: $episode)';
  }
}
