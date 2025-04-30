// ignore_for_file: public_member_api_docs, sort_constructors_first

class PaginationInfo {
  final int? next;
  final int? prev;
  const PaginationInfo({this.next, this.prev});

  bool get canLoadMore => next != null;

  int get current {
    if ((next != null && prev != null) || prev != null) {
      return prev! + 1;
    } else if (next != null) {
      return next! - 1;
    }
    return 1;
  }

  Map<String, dynamic> toJson() => {};

  factory PaginationInfo.fromJson(Map<String, dynamic> json) => PaginationInfo(
    next:
        json['next'] != null
            ? int.tryParse(
              Uri.parse(json['next'] as String).queryParameters['page'] ?? '',
            )
            : null,
    prev:
        json['prev'] != null
            ? int.tryParse(
              Uri.parse(json['prev'] as String).queryParameters['page'] ?? '',
            )
            : null,
  );

  @override
  bool operator ==(covariant PaginationInfo other) {
    if (identical(this, other)) return true;

    return other.next == next;
  }

  @override
  int get hashCode => next.hashCode;
}
