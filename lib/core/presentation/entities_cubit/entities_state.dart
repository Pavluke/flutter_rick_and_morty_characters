// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'i_entities_cubit.dart';

class EntitiesState<E extends BaseEntity> extends Equatable {
  const EntitiesState({
    this.status = EntitiesCubitStatus.loading,
    this.entities = const [],
    this.paginationInfo = const PaginationInfo(),
    this.errorMsg = '',
    this.filter,
  });

  final EntitiesCubitStatus status;
  final List<E> entities;
  final PaginationInfo paginationInfo;
  final BaseEntityFilter? filter;
  final String errorMsg;

  EntitiesState<E> get withoutFilters => EntitiesState(
    entities: this.entities,
    errorMsg: this.errorMsg,
    paginationInfo: this.paginationInfo,
    status: this.status,
    filter: null,
  );

  EntitiesState<E> copyWith({
    EntitiesCubitStatus? status,
    List<E>? entities,
    PaginationInfo? paginationInfo,
    String? errorMsg,
    BaseEntityFilter? filter,
  }) {
    return EntitiesState(
      entities: entities ?? this.entities,
      errorMsg: errorMsg ?? this.errorMsg,
      paginationInfo: paginationInfo ?? this.paginationInfo,
      status: status ?? this.status,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [
    status,
    entities,
    paginationInfo,
    errorMsg,
    filter ?? DateTime.now(),
  ];
}
