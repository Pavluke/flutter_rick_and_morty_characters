// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class BaseEntityFilter implements _ToJson {
  final String name;
  const BaseEntityFilter({this.name = ''});

  @override
  String toString() => 'BaseEntityFilter(name: $name)';

  @override
  bool operator ==(covariant BaseEntityFilter other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

abstract interface class _ToJson {
  Map<String, dynamic> toJson();
}
