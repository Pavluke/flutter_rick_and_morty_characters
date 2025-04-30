part of 'favorite_entities_cubit.dart';

enum BaseFavoritesCubitStatus { loading, loaded, error }

extension CharactersCubitStateX on BaseFavoritesCubitStatus {
  /// Returns `true` if the enum value is [BaseFavoritesCubitStatus.loading].
  bool get isLoading => this == BaseFavoritesCubitStatus.loading;

  /// Returns `true` if the enum value is [BaseFavoritesCubitStatus.loaded].
  bool get isLoaded => this == BaseFavoritesCubitStatus.loaded;

  /// Returns `true` if the enum value is [BaseFavoritesCubitStatus.error].
  bool get isError => this == BaseFavoritesCubitStatus.error;

  /// Executes a function based on the enum value.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value.
  R when<R>({
    required R Function() loading,
    required R Function() loaded,
    required R Function() error,
  }) => switch (this) {
    BaseFavoritesCubitStatus.loading => loading(),
    BaseFavoritesCubitStatus.loaded => loaded(),
    BaseFavoritesCubitStatus.error => error(),
  };

  /// Executes a function based on the enum value, with a fallback.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value and can be null.
  /// [orElse] is called if the corresponding function is null.
  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? loading,
    R Function()? loaded,
    R Function()? error,
  }) => switch (this) {
    BaseFavoritesCubitStatus.loading => loading?.call() ?? orElse(),
    BaseFavoritesCubitStatus.loaded => loaded?.call() ?? orElse(),
    BaseFavoritesCubitStatus.error => error?.call() ?? orElse(),
  };

  /// Executes a function based on the enum value, returning null if no function is provided.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value and can be null.
  R? whenOrNull<R>({
    R? Function()? loading,
    R? Function()? loaded,
    R? Function()? error,
  }) => switch (this) {
    BaseFavoritesCubitStatus.loading => loading?.call(),
    BaseFavoritesCubitStatus.loaded => loaded?.call(),
    BaseFavoritesCubitStatus.error => error?.call(),
  };
}
