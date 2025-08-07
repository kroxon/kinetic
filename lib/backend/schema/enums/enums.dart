import 'package:collection/collection.dart';

enum AssistantMode {
  Enable,
  Disabled,
}

enum WorkoutPhase {
  Exercise,
  ShortRest,
  LongRest,
  Finish,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (AssistantMode):
      return AssistantMode.values.deserialize(value) as T?;
    case (WorkoutPhase):
      return WorkoutPhase.values.deserialize(value) as T?;
    default:
      return null;
  }
}
