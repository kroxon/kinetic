// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VoicesStruct extends FFFirebaseStruct {
  VoicesStruct({
    String? label,
    String? value,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _label = label,
        _value = value,
        super(firestoreUtilData);

  // "label" field.
  String? _label;
  String get label => _label ?? '';
  set label(String? val) => _label = val;

  bool hasLabel() => _label != null;

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  set value(String? val) => _value = val;

  bool hasValue() => _value != null;

  static VoicesStruct fromMap(Map<String, dynamic> data) => VoicesStruct(
        label: data['label'] as String?,
        value: data['value'] as String?,
      );

  static VoicesStruct? maybeFromMap(dynamic data) =>
      data is Map ? VoicesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'label': _label,
        'value': _value,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'label': serializeParam(
          _label,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.String,
        ),
      }.withoutNulls;

  static VoicesStruct fromSerializableMap(Map<String, dynamic> data) =>
      VoicesStruct(
        label: deserializeParam(
          data['label'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'VoicesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VoicesStruct &&
        label == other.label &&
        value == other.value;
  }

  @override
  int get hashCode => const ListEquality().hash([label, value]);
}

VoicesStruct createVoicesStruct({
  String? label,
  String? value,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    VoicesStruct(
      label: label,
      value: value,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

VoicesStruct? updateVoicesStruct(
  VoicesStruct? voices, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    voices
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addVoicesStructData(
  Map<String, dynamic> firestoreData,
  VoicesStruct? voices,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (voices == null) {
    return;
  }
  if (voices.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && voices.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final voicesData = getVoicesFirestoreData(voices, forFieldValue);
  final nestedData = voicesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = voices.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getVoicesFirestoreData(
  VoicesStruct? voices, [
  bool forFieldValue = false,
]) {
  if (voices == null) {
    return {};
  }
  final firestoreData = mapToFirestore(voices.toMap());

  // Add any Firestore field values
  voices.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getVoicesListFirestoreData(
  List<VoicesStruct>? voicess,
) =>
    voicess?.map((e) => getVoicesFirestoreData(e, true)).toList() ?? [];
