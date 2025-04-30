abstract class BaseEntity {
  final int id;
  final String name;
  final String url;
  final DateTime created;

  BaseEntity({
    required this.id,
    required this.name,
    required this.url,
    required this.created,
  });

  Map<String, dynamic> toJson();
}
