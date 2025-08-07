// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorkoutStruct extends FFFirebaseStruct {
  WorkoutStruct({
    String? workoutName,
    int? numberOfCycles,
    int? numberOfExercises,
    int? exerciseDuration,
    int? shortRest,
    int? longRest,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _workoutName = workoutName,
        _numberOfCycles = numberOfCycles,
        _numberOfExercises = numberOfExercises,
        _exerciseDuration = exerciseDuration,
        _shortRest = shortRest,
        _longRest = longRest,
        super(firestoreUtilData);

  // "workoutName" field.
  String? _workoutName;
  String get workoutName => _workoutName ?? 'Primary';
  set workoutName(String? val) => _workoutName = val;

  bool hasWorkoutName() => _workoutName != null;

  // "numberOfCycles" field.
  int? _numberOfCycles;
  int get numberOfCycles => _numberOfCycles ?? 2;
  set numberOfCycles(int? val) => _numberOfCycles = val;

  void incrementNumberOfCycles(int amount) =>
      numberOfCycles = numberOfCycles + amount;

  bool hasNumberOfCycles() => _numberOfCycles != null;

  // "numberOfExercises" field.
  int? _numberOfExercises;
  int get numberOfExercises => _numberOfExercises ?? 3;
  set numberOfExercises(int? val) => _numberOfExercises = val;

  void incrementNumberOfExercises(int amount) =>
      numberOfExercises = numberOfExercises + amount;

  bool hasNumberOfExercises() => _numberOfExercises != null;

  // "exerciseDuration" field.
  int? _exerciseDuration;
  int get exerciseDuration => _exerciseDuration ?? 20;
  set exerciseDuration(int? val) => _exerciseDuration = val;

  void incrementExerciseDuration(int amount) =>
      exerciseDuration = exerciseDuration + amount;

  bool hasExerciseDuration() => _exerciseDuration != null;

  // "shortRest" field.
  int? _shortRest;
  int get shortRest => _shortRest ?? 7;
  set shortRest(int? val) => _shortRest = val;

  void incrementShortRest(int amount) => shortRest = shortRest + amount;

  bool hasShortRest() => _shortRest != null;

  // "longRest" field.
  int? _longRest;
  int get longRest => _longRest ?? 30;
  set longRest(int? val) => _longRest = val;

  void incrementLongRest(int amount) => longRest = longRest + amount;

  bool hasLongRest() => _longRest != null;

  static WorkoutStruct fromMap(Map<String, dynamic> data) => WorkoutStruct(
        workoutName: data['workoutName'] as String?,
        numberOfCycles: castToType<int>(data['numberOfCycles']),
        numberOfExercises: castToType<int>(data['numberOfExercises']),
        exerciseDuration: castToType<int>(data['exerciseDuration']),
        shortRest: castToType<int>(data['shortRest']),
        longRest: castToType<int>(data['longRest']),
      );

  static WorkoutStruct? maybeFromMap(dynamic data) =>
      data is Map ? WorkoutStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'workoutName': _workoutName,
        'numberOfCycles': _numberOfCycles,
        'numberOfExercises': _numberOfExercises,
        'exerciseDuration': _exerciseDuration,
        'shortRest': _shortRest,
        'longRest': _longRest,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'workoutName': serializeParam(
          _workoutName,
          ParamType.String,
        ),
        'numberOfCycles': serializeParam(
          _numberOfCycles,
          ParamType.int,
        ),
        'numberOfExercises': serializeParam(
          _numberOfExercises,
          ParamType.int,
        ),
        'exerciseDuration': serializeParam(
          _exerciseDuration,
          ParamType.int,
        ),
        'shortRest': serializeParam(
          _shortRest,
          ParamType.int,
        ),
        'longRest': serializeParam(
          _longRest,
          ParamType.int,
        ),
      }.withoutNulls;

  static WorkoutStruct fromSerializableMap(Map<String, dynamic> data) =>
      WorkoutStruct(
        workoutName: deserializeParam(
          data['workoutName'],
          ParamType.String,
          false,
        ),
        numberOfCycles: deserializeParam(
          data['numberOfCycles'],
          ParamType.int,
          false,
        ),
        numberOfExercises: deserializeParam(
          data['numberOfExercises'],
          ParamType.int,
          false,
        ),
        exerciseDuration: deserializeParam(
          data['exerciseDuration'],
          ParamType.int,
          false,
        ),
        shortRest: deserializeParam(
          data['shortRest'],
          ParamType.int,
          false,
        ),
        longRest: deserializeParam(
          data['longRest'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'WorkoutStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is WorkoutStruct &&
        workoutName == other.workoutName &&
        numberOfCycles == other.numberOfCycles &&
        numberOfExercises == other.numberOfExercises &&
        exerciseDuration == other.exerciseDuration &&
        shortRest == other.shortRest &&
        longRest == other.longRest;
  }

  @override
  int get hashCode => const ListEquality().hash([
        workoutName,
        numberOfCycles,
        numberOfExercises,
        exerciseDuration,
        shortRest,
        longRest
      ]);
}

WorkoutStruct createWorkoutStruct({
  String? workoutName,
  int? numberOfCycles,
  int? numberOfExercises,
  int? exerciseDuration,
  int? shortRest,
  int? longRest,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    WorkoutStruct(
      workoutName: workoutName,
      numberOfCycles: numberOfCycles,
      numberOfExercises: numberOfExercises,
      exerciseDuration: exerciseDuration,
      shortRest: shortRest,
      longRest: longRest,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

WorkoutStruct? updateWorkoutStruct(
  WorkoutStruct? workout, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    workout
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addWorkoutStructData(
  Map<String, dynamic> firestoreData,
  WorkoutStruct? workout,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (workout == null) {
    return;
  }
  if (workout.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && workout.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final workoutData = getWorkoutFirestoreData(workout, forFieldValue);
  final nestedData = workoutData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = workout.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getWorkoutFirestoreData(
  WorkoutStruct? workout, [
  bool forFieldValue = false,
]) {
  if (workout == null) {
    return {};
  }
  final firestoreData = mapToFirestore(workout.toMap());

  // Add any Firestore field values
  workout.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getWorkoutListFirestoreData(
  List<WorkoutStruct>? workouts,
) =>
    workouts?.map((e) => getWorkoutFirestoreData(e, true)).toList() ?? [];
