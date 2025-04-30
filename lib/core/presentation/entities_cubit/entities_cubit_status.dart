enum EntitiesCubitStatus { loading, loaded, error }

extension EntitiesCubitStatusX on EntitiesCubitStatus {
  /// Returns `true` if the enum value is [EntitiesCubitStatus.loading].
  bool get isLoading => this == EntitiesCubitStatus.loading;

  /// Returns `true` if the enum value is [EntitiesCubitStatus.loaded].
  bool get isLoaded => this == EntitiesCubitStatus.loaded;

  /// Returns `true` if the enum value is [EntitiesCubitStatus.error].
  bool get isError => this == EntitiesCubitStatus.error;

  /// Executes a function based on the enum value.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value.
  R when<R>({
    required R Function() loading,
    required R Function() loaded,
    required R Function() error,
  }) => switch (this) {
    EntitiesCubitStatus.loading => loading(),
    EntitiesCubitStatus.loaded => loaded(),
    EntitiesCubitStatus.error => error(),
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
    EntitiesCubitStatus.loading => loading?.call() ?? orElse(),
    EntitiesCubitStatus.loaded => loaded?.call() ?? orElse(),
    EntitiesCubitStatus.error => error?.call() ?? orElse(),
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
    EntitiesCubitStatus.loading => loading?.call(),
    EntitiesCubitStatus.loaded => loaded?.call(),
    EntitiesCubitStatus.error => error?.call(),
  };
}
