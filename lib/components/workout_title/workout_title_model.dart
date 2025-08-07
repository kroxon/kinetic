import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'workout_title_widget.dart' show WorkoutTitleWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WorkoutTitleModel extends FlutterFlowModel<WorkoutTitleWidget> {
  ///  Local state fields for this component.

  WorkoutStruct? workout;
  void updateWorkoutStruct(Function(WorkoutStruct) updateFn) {
    updateFn(workout ??= WorkoutStruct());
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
