import '/backend/schema/structs/index.dart';
import '/components/voice_picker_dialog/voice_picker_dialog_widget.dart';
import '/components/workout_title/workout_title_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_language_selector.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'drawer_column_widget.dart' show DrawerColumnWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DrawerColumnModel extends FlutterFlowModel<DrawerColumnWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TemperaturSlider widget.
  double? temperaturSliderValue;
  // State field(s) for TopPSlider widget.
  double? topPSliderValue;
  // State field(s) for AiTextPropertiesTextField widget.
  FocusNode? aiTextPropertiesTextFieldFocusNode;
  TextEditingController? aiTextPropertiesTextFieldTextController;
  String? Function(BuildContext, String?)?
      aiTextPropertiesTextFieldTextControllerValidator;
  // State field(s) for AiVoiceStyleTextField widget.
  FocusNode? aiVoiceStyleTextFieldFocusNode;
  TextEditingController? aiVoiceStyleTextFieldTextController;
  String? Function(BuildContext, String?)?
      aiVoiceStyleTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    aiTextPropertiesTextFieldFocusNode?.dispose();
    aiTextPropertiesTextFieldTextController?.dispose();

    aiVoiceStyleTextFieldFocusNode?.dispose();
    aiVoiceStyleTextFieldTextController?.dispose();
  }
}
