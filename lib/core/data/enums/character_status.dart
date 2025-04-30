enum CharacterStatus { alive, dead, unknown }

extension CharacterStatusX on CharacterStatus {
  /// Returns `true` if the enum value is [CharacterStatus.alive].
  bool get isAlive => this == CharacterStatus.alive;

  /// Returns `true` if the enum value is [CharacterStatus.dead].
  bool get isDead => this == CharacterStatus.dead;

  /// Returns `true` if the enum value is [CharacterStatus.unknown].
  bool get isUnknown => this == CharacterStatus.unknown;

  /// Executes a function based on the enum value.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value.
  R when<R>({
    required R Function() alive,
    required R Function() dead,
    required R Function() unknown,
  }) => switch (this) {
    CharacterStatus.alive => alive(),
    CharacterStatus.dead => dead(),
    CharacterStatus.unknown => unknown(),
  };

  /// Executes a function based on the enum value, with a fallback.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value and can be null.
  /// [orElse] is called if the corresponding function is null.
  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? alive,
    R Function()? dead,
    R Function()? unknown,
  }) => switch (this) {
    CharacterStatus.alive => alive?.call() ?? orElse(),
    CharacterStatus.dead => dead?.call() ?? orElse(),
    CharacterStatus.unknown => unknown?.call() ?? orElse(),
  };

  /// Executes a function based on the enum value, returning null if no function is provided.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value and can be null.
  R? whenOrNull<R>({
    R? Function()? alive,
    R? Function()? dead,
    R? Function()? unknown,
  }) => switch (this) {
    CharacterStatus.alive => alive?.call(),
    CharacterStatus.dead => dead?.call(),
    CharacterStatus.unknown => unknown?.call(),
  };
}

extension CharacterStatusParser on CharacterStatus {
  static CharacterStatus fromString(String? value) {
    if (value == null) {
      return CharacterStatus.unknown;
    }
    return CharacterStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse:
          () => throw ArgumentError('Invalid CharacterStatus value: $value'),
    );
  }

  String toStringValue() {
    return name;
  }
}
