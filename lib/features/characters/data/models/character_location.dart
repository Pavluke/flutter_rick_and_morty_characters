class CharacterLocation {
  final String url;
  final String name;

  CharacterLocation({required this.url, required this.name});
  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      CharacterLocation(
        name: json['name'] as String,
        url: json['url'] as String,
      );

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
  @override
  String toString() => 'CharacterLocation(url: $url, name: $name)';

  @override
  bool operator ==(covariant CharacterLocation other) {
    if (identical(this, other)) return true;

    return other.url == url && other.name == name;
  }

  @override
  int get hashCode => url.hashCode ^ name.hashCode;
}
