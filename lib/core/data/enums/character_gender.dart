enum CharacterGender { male, female, unknown }

extension CharacterGenderX on CharacterGender {
  /// Returns `true` if the enum value is [CharacterGender.male].
  bool get isMale => this == CharacterGender.male;

  /// Returns `true` if the enum value is [CharacterGender.female].
  bool get isFemale => this == CharacterGender.female;

  /// Returns `true` if the enum value is [CharacterGender.unknown].
  bool get isUnknown => this == CharacterGender.unknown;

  /// Executes a function based on the enum value.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value.
  R when<R>({
    required R Function() male,
    required R Function() female,
    required R Function() unknown,
  }) => switch (this) {
    CharacterGender.male => male(),
    CharacterGender.female => female(),
    CharacterGender.unknown => unknown(),
  };

  /// Executes a function based on the enum value, with a fallback.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value and can be null.
  /// [orElse] is called if the corresponding function is null.
  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? male,
    R Function()? female,
    R Function()? unknown,
  }) => switch (this) {
    CharacterGender.male => male?.call() ?? orElse(),
    CharacterGender.female => female?.call() ?? orElse(),
    CharacterGender.unknown => unknown?.call() ?? orElse(),
  };

  /// Executes a function based on the enum value, returning null if no function is provided.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value and can be null.
  R? whenOrNull<R>({
    R? Function()? male,
    R? Function()? female,
    R? Function()? unknown,
  }) => switch (this) {
    CharacterGender.male => male?.call(),
    CharacterGender.female => female?.call(),
    CharacterGender.unknown => unknown?.call(),
  };
}

extension CharacterGenderParser on CharacterGender {
  static CharacterGender fromString(String? value) {
    if (value == null) {
      return CharacterGender.unknown;
    }
    return CharacterGender.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse:
          () => throw ArgumentError('Invalid CharacterGender value: $value'),
    );
  }

  String toStringValue() => name;
}
