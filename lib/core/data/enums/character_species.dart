enum CharacterSpecies { human, alien, humanoid, poopybutthole, unknown }

extension CharacterSpeciesX on CharacterSpecies {
  /// Returns `true` if the enum value is [CharacterSpecies.human].
  bool get isHuman => this == CharacterSpecies.human;

  /// Returns `true` if the enum value is [CharacterSpecies.alien].
  bool get isAlien => this == CharacterSpecies.alien;

  /// Returns `true` if the enum value is [CharacterSpecies.humanoid].
  bool get isHumanoid => this == CharacterSpecies.humanoid;

  /// Returns `true` if the enum value is [CharacterSpecies.poopybutthole].
  bool get isPoopybutthole => this == CharacterSpecies.poopybutthole;

  /// Returns `true` if the enum value is [CharacterSpecies.unknown].
  bool get isUnknown => this == CharacterSpecies.unknown;

  /// Executes a function based on the enum value.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value.
  R when<R>({
    required R Function() human,
    required R Function() alien,
    required R Function() humanoid,
    required R Function() poopybutthole,
    required R Function() unknown,
  }) => switch (this) {
    CharacterSpecies.human => human(),
    CharacterSpecies.alien => alien(),
    CharacterSpecies.humanoid => humanoid(),
    CharacterSpecies.poopybutthole => poopybutthole(),
    CharacterSpecies.unknown => unknown(),
  };

  /// Executes a function based on the enum value, with a fallback.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value and can be null.
  /// [orElse] is called if the corresponding function is null.
  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? human,
    R Function()? alien,
    R Function()? humanoid,
    R Function()? poopybutthole,
    R Function()? unknown,
  }) => switch (this) {
    CharacterSpecies.human => human?.call() ?? orElse(),
    CharacterSpecies.alien => alien?.call() ?? orElse(),
    CharacterSpecies.humanoid => humanoid?.call() ?? orElse(),
    CharacterSpecies.poopybutthole => poopybutthole?.call() ?? orElse(),
    CharacterSpecies.unknown => unknown?.call() ?? orElse(),
  };

  /// Executes a function based on the enum value, returning null if no function is provided.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value and can be null.
  R? whenOrNull<R>({
    R? Function()? human,
    R? Function()? alien,
    R? Function()? humanoid,
    R? Function()? poopybutthole,
    R? Function()? unknown,
  }) => switch (this) {
    CharacterSpecies.human => human?.call(),
    CharacterSpecies.alien => alien?.call(),
    CharacterSpecies.humanoid => humanoid?.call(),
    CharacterSpecies.poopybutthole => poopybutthole?.call(),
    CharacterSpecies.unknown => unknown?.call(),
  };
}

extension CharacterSpeciesParser on CharacterSpecies {
  static CharacterSpecies? fromString(String value) =>
      CharacterSpecies.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toLowerCase(),
        orElse: () => CharacterSpecies.unknown,
      );

  String toStringValue() => name;
}
