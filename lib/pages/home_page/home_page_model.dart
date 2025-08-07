import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/drawer_column/drawer_column_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  int? currentCycle;

  int? currentExercise;

  int? remainingTime;

  WorkoutStruct? currentWorkout;
  void updateCurrentWorkoutStruct(Function(WorkoutStruct) updateFn) {
    updateFn(currentWorkout ??= WorkoutStruct());
  }

  bool isPlaying = false;

  int? exerciseTime;

  int? restBetweenExercisesTime;

  int? restBetweenCyclesTime;

  bool? isSpeaking = false;

  WorkoutPhase? workoutPhase = WorkoutPhase.ShortRest;

  String? apiRespondTest;

  String? test2;

  String? quoteExercise;

  String? quoteRest;

  String? quoteDisplay;

  bool testMode = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Timer widget.
  final timerInitialTimeMs1 = 0;
  int timerMilliseconds1 = 0;
  String timerValue1 = StopWatchTimer.getDisplayTime(
    0,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController1 =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // State field(s) for Timer widget.
  final timerInitialTimeMs2 = 1000;
  int timerMilliseconds2 = 1000;
  String timerValue2 = StopWatchTimer.getDisplayTime(
    1000,
    hours: false,
    minute: false,
  );
  FlutterFlowTimerController timerController2 =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Backend Call - API (GeminiGenerateText)] action in Timer widget.
  ApiCallResponse? generatedTextPreload;
  // Stores action output result for [Backend Call - API (GeminiGenerateText)] action in Timer widget.
  ApiCallResponse? generatedStylePreload;
  // Stores action output result for [Backend Call - API (GeminiGenerateText)] action in Timer widget.
  ApiCallResponse? generatedTextPreload2;
  // Stores action output result for [Backend Call - API (GeminiGenerateText)] action in Timer widget.
  ApiCallResponse? generateStylePreload2;
  // Stores action output result for [Backend Call - API (GoogleTTSNative)] action in Timer widget.
  ApiCallResponse? geminiTTSRespond3;
  // Stores action output result for [Backend Call - API (GoogleTTSNative)] action in Timer widget.
  ApiCallResponse? geminiTTSRespond4;
  // Model for DrawerColumn component.
  late DrawerColumnModel drawerColumnModel;

  @override
  void initState(BuildContext context) {
    drawerColumnModel = createModel(context, () => DrawerColumnModel());
  }

  @override
  void dispose() {
    timerController1.dispose();
    timerController2.dispose();
    drawerColumnModel.dispose();
  }
}
