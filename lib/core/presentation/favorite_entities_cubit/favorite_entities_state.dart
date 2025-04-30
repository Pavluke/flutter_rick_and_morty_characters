// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorite_entities_cubit.dart';

class FavoriteEntitiesState<E extends BaseEntity> extends Equatable {
  const FavoriteEntitiesState({
    this.status = BaseFavoritesCubitStatus.loading,
    this.favorites = const [],
    this.errorMsg = '',
  });

  final BaseFavoritesCubitStatus status;
  final List<E> favorites;
  final String errorMsg;

  FavoriteEntitiesState<E> copyWith({
    BaseFavoritesCubitStatus? status,
    List<E>? entities,
    String? errorMsg,
  }) => FavoriteEntitiesState(
    favorites: entities ?? this.favorites,
    errorMsg: errorMsg ?? this.errorMsg,
    status: status ?? this.status,
  );

  @override
  List<Object> get props => [status, favorites, errorMsg];
}
