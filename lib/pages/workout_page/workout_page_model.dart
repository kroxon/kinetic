import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'workout_page_widget.dart' show WorkoutPageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WorkoutPageModel extends FlutterFlowModel<WorkoutPageWidget> {
  ///  Local state fields for this page.

  WorkoutStruct? workout;
  void updateWorkoutStruct(Function(WorkoutStruct) updateFn) {
    updateFn(workout ??= WorkoutStruct());
  }

  ///  State fields for stateful widgets in this page.

  // State field(s) for NameTextField widget.
  FocusNode? nameTextFieldFocusNode;
  TextEditingController? nameTextFieldTextController;
  String? Function(BuildContext, String?)? nameTextFieldTextControllerValidator;
  // State field(s) for NumberOfCyclesText widget.
  FocusNode? numberOfCyclesTextFocusNode;
  TextEditingController? numberOfCyclesTextTextController;
  String? Function(BuildContext, String?)?
      numberOfCyclesTextTextControllerValidator;
  // State field(s) for NumberOfExercisesText widget.
  FocusNode? numberOfExercisesTextFocusNode;
  TextEditingController? numberOfExercisesTextTextController;
  String? Function(BuildContext, String?)?
      numberOfExercisesTextTextControllerValidator;
  // State field(s) for ExerciseDurMinTextField widget.
  FocusNode? exerciseDurMinTextFieldFocusNode;
  TextEditingController? exerciseDurMinTextFieldTextController;
  String? Function(BuildContext, String?)?
      exerciseDurMinTextFieldTextControllerValidator;
  // State field(s) for ExerciseDurSecTextField widget.
  FocusNode? exerciseDurSecTextFieldFocusNode;
  TextEditingController? exerciseDurSecTextFieldTextController;
  String? Function(BuildContext, String?)?
      exerciseDurSecTextFieldTextControllerValidator;
  // State field(s) for RestDurMinTextField widget.
  FocusNode? restDurMinTextFieldFocusNode;
  TextEditingController? restDurMinTextFieldTextController;
  String? Function(BuildContext, String?)?
      restDurMinTextFieldTextControllerValidator;
  // State field(s) for RestDurSecTextField widget.
  FocusNode? restDurSecTextFieldFocusNode;
  TextEditingController? restDurSecTextFieldTextController;
  String? Function(BuildContext, String?)?
      restDurSecTextFieldTextControllerValidator;
  // State field(s) for BetweenCyclesMinTextField widget.
  FocusNode? betweenCyclesMinTextFieldFocusNode;
  TextEditingController? betweenCyclesMinTextFieldTextController;
  String? Function(BuildContext, String?)?
      betweenCyclesMinTextFieldTextControllerValidator;
  // State field(s) for BetweenCyclesSecTextField widget.
  FocusNode? betweenCyclesSecTextFieldFocusNode;
  TextEditingController? betweenCyclesSecTextFieldTextController;
  String? Function(BuildContext, String?)?
      betweenCyclesSecTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameTextFieldFocusNode?.dispose();
    nameTextFieldTextController?.dispose();

    numberOfCyclesTextFocusNode?.dispose();
    numberOfCyclesTextTextController?.dispose();

    numberOfExercisesTextFocusNode?.dispose();
    numberOfExercisesTextTextController?.dispose();

    exerciseDurMinTextFieldFocusNode?.dispose();
    exerciseDurMinTextFieldTextController?.dispose();

    exerciseDurSecTextFieldFocusNode?.dispose();
    exerciseDurSecTextFieldTextController?.dispose();

    restDurMinTextFieldFocusNode?.dispose();
    restDurMinTextFieldTextController?.dispose();

    restDurSecTextFieldFocusNode?.dispose();
    restDurSecTextFieldTextController?.dispose();

    betweenCyclesMinTextFieldFocusNode?.dispose();
    betweenCyclesMinTextFieldTextController?.dispose();

    betweenCyclesSecTextFieldFocusNode?.dispose();
    betweenCyclesSecTextFieldTextController?.dispose();
  }
}
