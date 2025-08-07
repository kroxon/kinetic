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
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.currentCycle = 1;
      _model.currentExercise = 1;
      _model.remainingTime = FFAppState()
              .myWorkouts
              .elementAtOrNull(FFAppState().currentWorkoutIndex)!
              .exerciseDuration *
          1000;
      _model.currentWorkout = FFAppState()
          .myWorkouts
          .elementAtOrNull(FFAppState().currentWorkoutIndex);
      _model.exerciseTime = FFAppState()
              .myWorkouts
              .elementAtOrNull(FFAppState().currentWorkoutIndex)!
              .exerciseDuration *
          1000;
      _model.restBetweenExercisesTime = FFAppState()
              .myWorkouts
              .elementAtOrNull(FFAppState().currentWorkoutIndex)!
              .shortRest *
          1000;
      _model.restBetweenCyclesTime = FFAppState()
              .myWorkouts
              .elementAtOrNull(FFAppState().currentWorkoutIndex)!
              .longRest *
          1000;
      _model.isSpeaking = false;
      _model.workoutPhase = WorkoutPhase.Exercise;
      safeSetState(() {});
      FFAppState().isPlaying = false;
      safeSetState(() {});
      _model.timerController1.timer.setPresetTime(
        mSec: (_model.remainingTime!) * 1000,
        add: false,
      );
      _model.timerController1.onResetTimer();

      _model.timerController2.onStartTimer();
    });

    animationsMap.addAll({
      'lottieAnimationOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconButtonOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.03, 1.03),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 300.0.ms,
            begin: Offset(1.03, 1.03),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          elevation: 16.0,
          child: wrapWithModel(
            model: _model.drawerColumnModel,
            updateCallback: () => safeSetState(() {}),
            child: DrawerColumnWidget(),
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional(0.0, 1.0),
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    FFAppState().myWorkouts.length > 0
                                        ? valueOrDefault<String>(
                                            FFAppState()
                                                .myWorkouts
                                                .elementAtOrNull(FFAppState()
                                                    .currentWorkoutIndex)
                                                ?.workoutName,
                                            '0',
                                          )
                                        : 'Workout',
                                    'Primary',
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .headlineLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineLarge
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .fontStyle,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, -1.0),
                                child: FlutterFlowIconButton(
                                  borderRadius: 8.0,
                                  buttonSize: 40.0,
                                  icon: Icon(
                                    Icons.menu,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    scaffoldKey.currentState!.openDrawer();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      decoration: BoxDecoration(),
                      child: Stack(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.0, -1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 0.0, 0.0),
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '435cpe01' /* Cycle */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Text(
                                      '${_model.currentCycle?.toString()}/${_model.currentWorkout?.numberOfCycles?.toString()}',
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleLarge
                                                    .fontStyle,
                                          ),
                                    ),
                                  ]
                                      .divide(SizedBox(height: 8.0))
                                      .addToStart(SizedBox(height: 8.0))
                                      .addToEnd(SizedBox(height: 8.0)),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1.0, -1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 0.0, 0.0),
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'lj3a4ej5' /* Exercise */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Text(
                                      '${_model.currentExercise?.toString()}/${_model.currentWorkout?.numberOfExercises?.toString()}',
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleLarge
                                                    .fontStyle,
                                          ),
                                    ),
                                  ]
                                      .divide(SizedBox(height: 8.0))
                                      .addToStart(SizedBox(height: 8.0))
                                      .addToEnd(SizedBox(height: 8.0)),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 10.0,
                              shape: const CircleBorder(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: () {
                                    if (_model.workoutPhase ==
                                        WorkoutPhase.Exercise) {
                                      return Color(0xFFF04E4E);
                                    } else if (_model.workoutPhase ==
                                        WorkoutPhase.ShortRest) {
                                      return Color(0xFFEDEB7D);
                                    } else if (_model.workoutPhase ==
                                        WorkoutPhase.LongRest) {
                                      return Color(0xFF86F08A);
                                    } else {
                                      return Color(0xFFBB90DA);
                                    }
                                  }(),
                                  shape: BoxShape.circle,
                                ),
                                child: CircularPercentIndicator(
                                  percent: functions.progreBarValue(
                                      _model.timerMilliseconds1,
                                      _model.remainingTime!),
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.3,
                                  lineWidth: 18.0,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  progressColor:
                                      FlutterFlowTheme.of(context).primary,
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: FlutterFlowTimer(
                                    initialTime: _model.remainingTime!,
                                    getDisplayTime: (value) =>
                                        StopWatchTimer.getDisplayTime(
                                      value,
                                      hours: false,
                                      milliSecond: false,
                                    ),
                                    controller: _model.timerController1,
                                    updateStateInterval:
                                        Duration(milliseconds: 10),
                                    onChanged:
                                        (value, displayTime, shouldUpdate) {
                                      _model.timerMilliseconds1 = value;
                                      _model.timerValue1 = displayTime;
                                      if (shouldUpdate) safeSetState(() {});
                                    },
                                    onEnded: () async {
                                      if (_model.workoutPhase ==
                                          WorkoutPhase.Exercise) {
                                        if (_model.currentExercise !=
                                            _model.currentWorkout
                                                ?.numberOfExercises) {
                                          _model.remainingTime =
                                              _model.restBetweenExercisesTime;
                                          _model.workoutPhase =
                                              WorkoutPhase.ShortRest;
                                          safeSetState(() {});
                                          _model.timerController1.timer
                                              .setPresetTime(
                                            mSec: _model.remainingTime!,
                                            add: false,
                                          );
                                          _model.timerController1
                                              .onResetTimer();

                                          _model.timerController1
                                              .onStartTimer();
                                        } else {
                                          if (_model.currentCycle !=
                                              _model.currentWorkout
                                                  ?.numberOfCycles) {
                                            _model.remainingTime =
                                                _model.restBetweenCyclesTime;
                                            _model.workoutPhase =
                                                WorkoutPhase.LongRest;
                                            safeSetState(() {});
                                            _model.timerController1.timer
                                                .setPresetTime(
                                              mSec: _model.remainingTime!,
                                              add: false,
                                            );
                                            _model.timerController1
                                                .onResetTimer();

                                            _model.timerController1
                                                .onStartTimer();
                                          } else {
                                            _model.workoutPhase =
                                                WorkoutPhase.Finish;
                                            safeSetState(() {});
                                            _model.timerController1.timer
                                                .setPresetTime(
                                              mSec: _model.exerciseTime!,
                                              add: false,
                                            );
                                            _model.timerController1
                                                .onResetTimer();
                                          }
                                        }
                                      } else if (_model.workoutPhase ==
                                          WorkoutPhase.ShortRest) {
                                        _model.currentExercise =
                                            _model.currentExercise! + 1;
                                        _model.remainingTime =
                                            _model.exerciseTime;
                                        _model.workoutPhase =
                                            WorkoutPhase.Exercise;
                                        safeSetState(() {});
                                        _model.timerController1.timer
                                            .setPresetTime(
                                          mSec: _model.remainingTime!,
                                          add: false,
                                        );
                                        _model.timerController1.onResetTimer();

                                        _model.timerController1.onStartTimer();
                                      } else if (_model.workoutPhase ==
                                          WorkoutPhase.LongRest) {
                                        _model.currentExercise = 1;
                                        _model.remainingTime =
                                            _model.exerciseTime;
                                        _model.currentCycle =
                                            _model.currentCycle! + 1;
                                        _model.workoutPhase =
                                            WorkoutPhase.Exercise;
                                        safeSetState(() {});
                                        _model.timerController1.timer
                                            .setPresetTime(
                                          mSec: _model.remainingTime!,
                                          add: false,
                                        );
                                        _model.timerController1.onResetTimer();

                                        _model.timerController1.onStartTimer();
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('6'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .displayLarge
                                        .override(
                                      font: GoogleFonts.chivoMono(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .displayLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .displayLarge
                                            .fontStyle,
                                      ),
                                      fontSize: 54.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .displayLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .displayLarge
                                          .fontStyle,
                                      shadows: [
                                        Shadow(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 1.0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1.0, 1.0),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.remainingTime =
                                      (_model.remainingTime!) + 5000;
                                  safeSetState(() {});
                                  _model.timerController1.timer.setPresetTime(
                                    mSec: _model.timerMilliseconds1 + 5000,
                                    add: false,
                                  );
                                  _model.timerController1.onResetTimer();

                                  if (_model.isPlaying == true) {
                                    _model.timerController1.onStartTimer();
                                  }
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 5.0,
                                  shape: const CircleBorder(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'uazhgbe5' /* + 5 */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1.0, 1.0),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.timerController1.timer.setPresetTime(
                                    mSec: (int var1) {
                                      return var1 - 5000 < 0 ? 1 : var1 - 5000;
                                    }(_model.timerMilliseconds1),
                                    add: false,
                                  );
                                  _model.timerController1.onResetTimer();

                                  if (_model.isPlaying == true) {
                                    _model.timerController1.onStartTimer();
                                  }
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 5.0,
                                  shape: const CircleBorder(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'fyhvvz6k' /* - 5 */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderRadius: 8.0,
                              buttonSize: 70.0,
                              icon: Icon(
                                Icons.skip_previous,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 60.0,
                              ),
                              onPressed: () async {
                                if (_model.workoutPhase ==
                                    WorkoutPhase.Exercise) {
                                  if (_model.currentCycle != 1) {
                                    if (_model.currentExercise != 1) {
                                      _model.remainingTime =
                                          _model.restBetweenExercisesTime;
                                      _model.workoutPhase =
                                          WorkoutPhase.ShortRest;
                                      _model.currentExercise =
                                          _model.currentExercise! + -1;
                                      safeSetState(() {});
                                      _model.timerController1.timer
                                          .setPresetTime(
                                        mSec: _model.remainingTime!,
                                        add: false,
                                      );
                                      _model.timerController1.onResetTimer();

                                      _model.timerController1.onStartTimer();
                                    } else {
                                      _model.remainingTime =
                                          _model.restBetweenCyclesTime;
                                      _model.workoutPhase =
                                          WorkoutPhase.LongRest;
                                      _model.currentCycle =
                                          _model.currentCycle! + -1;
                                      _model.currentExercise = _model
                                          .currentWorkout?.numberOfExercises;
                                      safeSetState(() {});
                                      _model.timerController1.timer
                                          .setPresetTime(
                                        mSec: _model.remainingTime!,
                                        add: false,
                                      );
                                      _model.timerController1.onResetTimer();

                                      _model.timerController1.onStartTimer();
                                    }
                                  } else {
                                    if (_model.currentExercise != 1) {
                                      _model.remainingTime =
                                          _model.restBetweenExercisesTime;
                                      _model.workoutPhase =
                                          WorkoutPhase.ShortRest;
                                      _model.currentExercise =
                                          _model.currentExercise! + -1;
                                      safeSetState(() {});
                                      _model.timerController1.timer
                                          .setPresetTime(
                                        mSec: _model.remainingTime!,
                                        add: false,
                                      );
                                      _model.timerController1.onResetTimer();

                                      _model.timerController1.onStartTimer();
                                    } else {
                                      _model.remainingTime =
                                          _model.exerciseTime;
                                      _model.workoutPhase =
                                          WorkoutPhase.Exercise;
                                      safeSetState(() {});
                                      _model.timerController1.timer
                                          .setPresetTime(
                                        mSec: _model.remainingTime!,
                                        add: false,
                                      );
                                      _model.timerController1.onResetTimer();

                                      if (FFAppState().isPlaying == true) {
                                        _model.timerController1.onStartTimer();
                                      }
                                    }
                                  }
                                } else if (_model.workoutPhase ==
                                    WorkoutPhase.ShortRest) {
                                  _model.currentExercise =
                                      _model.currentExercise! + 1;
                                  _model.remainingTime = _model.exerciseTime;
                                  _model.workoutPhase = WorkoutPhase.Exercise;
                                  safeSetState(() {});
                                  _model.timerController1.timer.setPresetTime(
                                    mSec: _model.remainingTime!,
                                    add: false,
                                  );
                                  _model.timerController1.onResetTimer();

                                  _model.timerController1.onStartTimer();
                                } else if (_model.workoutPhase ==
                                    WorkoutPhase.LongRest) {
                                  _model.currentCycle =
                                      _model.currentCycle! + 1;
                                  _model.currentExercise = 1;
                                  _model.remainingTime = _model.exerciseTime;
                                  _model.workoutPhase = WorkoutPhase.Exercise;
                                  safeSetState(() {});
                                  _model.timerController1.timer.setPresetTime(
                                    mSec: _model.remainingTime!,
                                    add: false,
                                  );
                                  _model.timerController1.onResetTimer();

                                  _model.timerController1.onStartTimer();
                                }
                              },
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderRadius: 8.0,
                              buttonSize: 70.0,
                              icon: Icon(
                                Icons.skip_next,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 60.0,
                              ),
                              onPressed: () async {
                                if (_model.workoutPhase ==
                                    WorkoutPhase.Exercise) {
                                  if (_model.currentCycle !=
                                      _model.currentWorkout?.numberOfCycles) {
                                    if (_model.currentExercise !=
                                        _model.currentWorkout
                                            ?.numberOfExercises) {
                                      _model.remainingTime =
                                          _model.restBetweenExercisesTime;
                                      _model.workoutPhase =
                                          WorkoutPhase.ShortRest;
                                      safeSetState(() {});
                                      _model.timerController1.timer
                                          .setPresetTime(
                                        mSec: _model.remainingTime!,
                                        add: false,
                                      );
                                      _model.timerController1.onResetTimer();

                                      _model.timerController1.onStartTimer();
                                    } else {
                                      _model.remainingTime =
                                          _model.restBetweenCyclesTime;
                                      _model.workoutPhase =
                                          WorkoutPhase.LongRest;
                                      safeSetState(() {});
                                      _model.timerController1.timer
                                          .setPresetTime(
                                        mSec: _model.remainingTime!,
                                        add: false,
                                      );
                                      _model.timerController1.onResetTimer();

                                      _model.timerController1.onStartTimer();
                                    }
                                  } else {
                                    if (_model.currentExercise !=
                                        _model.currentWorkout
                                            ?.numberOfExercises) {
                                      _model.remainingTime =
                                          _model.restBetweenExercisesTime;
                                      _model.workoutPhase =
                                          WorkoutPhase.ShortRest;
                                      safeSetState(() {});
                                      _model.timerController1.timer
                                          .setPresetTime(
                                        mSec: _model.remainingTime!,
                                        add: false,
                                      );
                                      _model.timerController1.onResetTimer();

                                      _model.timerController1.onStartTimer();
                                    } else {
                                      _model.remainingTime =
                                          _model.exerciseTime;
                                      _model.workoutPhase = WorkoutPhase.Finish;
                                      safeSetState(() {});
                                      _model.timerController1.timer
                                          .setPresetTime(
                                        mSec: _model.remainingTime!,
                                        add: false,
                                      );
                                      _model.timerController1.onResetTimer();
                                    }
                                  }
                                } else if (_model.workoutPhase ==
                                    WorkoutPhase.ShortRest) {
                                  _model.currentExercise =
                                      _model.currentExercise! + 1;
                                  _model.remainingTime = _model.exerciseTime;
                                  _model.workoutPhase = WorkoutPhase.Exercise;
                                  safeSetState(() {});
                                  _model.timerController1.timer.setPresetTime(
                                    mSec: _model.remainingTime!,
                                    add: false,
                                  );
                                  _model.timerController1.onResetTimer();

                                  _model.timerController1.onStartTimer();
                                } else if (_model.workoutPhase ==
                                    WorkoutPhase.LongRest) {
                                  _model.currentCycle =
                                      _model.currentCycle! + 1;
                                  _model.currentExercise = 1;
                                  _model.remainingTime = _model.exerciseTime;
                                  _model.workoutPhase = WorkoutPhase.Exercise;
                                  safeSetState(() {});
                                  _model.timerController1.timer.setPresetTime(
                                    mSec: _model.remainingTime!,
                                    add: false,
                                  );
                                  _model.timerController1.onResetTimer();

                                  _model.timerController1.onStartTimer();
                                }
                              },
                            ),
                          ),
                          if (_model.testMode)
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    _model.workoutPhase?.name,
                                    'start',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          if (_model.testMode)
                            Align(
                              alignment: AlignmentDirectional(-0.04, 1.13),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 40.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    _model.apiRespondTest,
                                    'wait',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 80.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'wj661xhg' /* Remaining */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 80.0, 0.0, 0.0),
                            child: Text(
                              functions
                                  .hundredthsOfSecond(_model.timerMilliseconds1)
                                  .maybeHandleOverflow(
                                    maxChars: 5,
                                  ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          if (_model.testMode)
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 100.0, 0.0, 0.0),
                                child: Text(
                                  FFAppState().cachedTextRestData != null &&
                                          FFAppState().cachedTextRestData != ''
                                      ? 'text rest is ready'
                                      : 'text rest file is empty',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          if (_model.testMode)
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 80.0, 0.0, 0.0),
                                child: Text(
                                  FFAppState().cachedAudioRestData != null &&
                                          FFAppState().cachedAudioRestData != ''
                                      ? 'audio rest is ready'
                                      : 'audio rest file is empty',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          Align(
                            alignment: AlignmentDirectional(1.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 80.0, 0.0),
                              child: FlutterFlowTimer(
                                initialTime: _model.timerInitialTimeMs2,
                                getDisplayTime: (value) =>
                                    StopWatchTimer.getDisplayTime(
                                  value,
                                  hours: false,
                                  minute: false,
                                ),
                                controller: _model.timerController2,
                                updateStateInterval:
                                    Duration(milliseconds: 100),
                                onChanged: (value, displayTime, shouldUpdate) {
                                  _model.timerMilliseconds2 = value;
                                  _model.timerValue2 = displayTime;
                                  if (shouldUpdate) safeSetState(() {});
                                },
                                onEnded: () async {
                                  _model.timerController2.timer
                                      .setPresetTime(mSec: 1000, add: false);
                                  _model.timerController2.onResetTimer();

                                  _model.timerController2.onStartTimer();
                                  if (FFAppState().assistantMode !=
                                      AssistantMode.Disabled) {
                                    await Future.wait([
                                      Future(() async {
                                        if (FFAppState().wasTextExerciseTaken ==
                                            true) {
                                          _model.generatedTextPreload =
                                              await GeminiGenerateTextCall.call(
                                            apiKey: FFAppState().geminiApiKey,
                                            userPrompt:
                                                functions.buildTextPrompt(
                                                    FFAppState()
                                                        .AiTextPromptProperties,
                                                    WorkoutPhase.Exercise,
                                                    FFLocalizations.of(context)
                                                        .languageCode),
                                            temperature:
                                                FFAppState().chatTemperature,
                                            topP: FFAppState().topP,
                                          );

                                          if ((_model.generatedTextPreload
                                                  ?.succeeded ??
                                              true)) {
                                            FFAppState()
                                                    .cachedTextExerciseData =
                                                GeminiGenerateTextCall
                                                    .generatedText(
                                              (_model.generatedTextPreload
                                                      ?.jsonBody ??
                                                  ''),
                                            )!;
                                            safeSetState(() {});
                                            _model.generatedStylePreload =
                                                await GeminiGenerateTextCall
                                                    .call(
                                              apiKey: FFAppState().geminiApiKey,
                                              userPrompt: functions.buildStylePrompt(
                                                  FFAppState()
                                                      .cachedTextExerciseData,
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                                  FFAppState()
                                                      .AiVoicePromptProperties),
                                              temperature:
                                                  FFAppState().chatTemperature,
                                              topP: FFAppState().topP,
                                            );

                                            if ((_model.generatedStylePreload
                                                    ?.succeeded ??
                                                true)) {
                                              FFAppState()
                                                      .cachedStyleExerciseData =
                                                  GeminiGenerateTextCall
                                                      .generatedText(
                                                (_model.generatedStylePreload
                                                        ?.jsonBody ??
                                                    ''),
                                              )!;
                                              FFAppState()
                                                  .wasTextExerciseTaken = false;
                                              safeSetState(() {});
                                            }
                                          }
                                        }
                                      }),
                                      Future(() async {
                                        if (FFAppState().wasTextRestTaken ==
                                            true) {
                                          _model.generatedTextPreload2 =
                                              await GeminiGenerateTextCall.call(
                                            apiKey: FFAppState().geminiApiKey,
                                            userPrompt:
                                                functions.buildTextPrompt(
                                                    FFAppState()
                                                        .AiTextPromptProperties,
                                                    WorkoutPhase.LongRest,
                                                    FFLocalizations.of(context)
                                                        .languageCode),
                                            temperature:
                                                FFAppState().chatTemperature,
                                            topP: FFAppState().topP,
                                          );

                                          if ((_model.generatedTextPreload2
                                                  ?.succeeded ??
                                              true)) {
                                            FFAppState().cachedTextRestData =
                                                GeminiGenerateTextCall
                                                    .generatedText(
                                              (_model.generatedTextPreload2
                                                      ?.jsonBody ??
                                                  ''),
                                            )!;
                                            safeSetState(() {});
                                            _model.generateStylePreload2 =
                                                await GeminiGenerateTextCall
                                                    .call(
                                              apiKey: FFAppState().geminiApiKey,
                                              userPrompt:
                                                  functions.buildStylePrompt(
                                                      FFAppState()
                                                          .cachedTextRestData,
                                                      FFLocalizations.of(
                                                              context)
                                                          .languageCode,
                                                      FFAppState()
                                                          .AiVoicePromptProperties),
                                              temperature:
                                                  FFAppState().chatTemperature,
                                              topP: FFAppState().topP,
                                            );

                                            if ((_model.generateStylePreload2
                                                    ?.succeeded ??
                                                true)) {
                                              FFAppState().cachedStyleRestData =
                                                  GeminiGenerateTextCall
                                                      .generatedText(
                                                (_model.generateStylePreload2
                                                        ?.jsonBody ??
                                                    ''),
                                              )!;
                                              FFAppState().wasTextRestTaken =
                                                  false;
                                              safeSetState(() {});
                                            }
                                          }
                                        }
                                      }),
                                      Future(() async {
                                        if ((FFAppState()
                                                    .wasAudioExerciseTaken ==
                                                true) &&
                                            (FFAppState()
                                                        .cachedTextExerciseData !=
                                                    null &&
                                                FFAppState()
                                                        .cachedTextExerciseData !=
                                                    '')) {
                                          _model.geminiTTSRespond3 =
                                              await GoogleTTSNativeCall.call(
                                            apiKey: FFAppState()
                                                .geminiTTSNativeApiKey,
                                            userPrompt:
                                                '${FFAppState().cachedStyleExerciseData}:${FFAppState().cachedTextExerciseData}',
                                            voiceName: FFAppState()
                                                .voices
                                                .elementAtOrNull(FFAppState()
                                                    .currentVoiceIndex)
                                                ?.label,
                                          );

                                          if ((_model.geminiTTSRespond3
                                                  ?.succeeded ??
                                              true)) {
                                            _model.quoteExercise = FFAppState()
                                                .cachedTextExerciseData;
                                            safeSetState(() {});
                                            FFAppState()
                                                    .cachedAudioExerciseData =
                                                GoogleTTSNativeCall.audioResult(
                                              (_model.geminiTTSRespond3
                                                      ?.jsonBody ??
                                                  ''),
                                            )!;
                                            FFAppState().wasAudioExerciseTaken =
                                                false;
                                            FFAppState().wasTextExerciseTaken =
                                                true;
                                            safeSetState(() {});
                                          }
                                        }
                                      }),
                                      Future(() async {
                                        if ((FFAppState().wasAudioRestTaken ==
                                                true) &&
                                            (FFAppState().cachedTextRestData !=
                                                    null &&
                                                FFAppState()
                                                        .cachedTextRestData !=
                                                    '')) {
                                          _model.geminiTTSRespond4 =
                                              await GoogleTTSNativeCall.call(
                                            apiKey: FFAppState()
                                                .geminiTTSNativeApiKey,
                                            userPrompt:
                                                '${FFAppState().cachedStyleRestData}:${FFAppState().cachedTextRestData}',
                                            voiceName: FFAppState()
                                                .voices
                                                .elementAtOrNull(FFAppState()
                                                    .currentVoiceIndex)
                                                ?.label,
                                          );

                                          if ((_model.geminiTTSRespond4
                                                  ?.succeeded ??
                                              true)) {
                                            _model.quoteRest =
                                                FFAppState().cachedTextRestData;
                                            safeSetState(() {});
                                            FFAppState().cachedAudioRestData =
                                                GoogleTTSNativeCall.audioResult(
                                              (_model.geminiTTSRespond4
                                                      ?.jsonBody ??
                                                  ''),
                                            )!;
                                            FFAppState().wasAudioRestTaken =
                                                false;
                                            FFAppState().wasTextRestTaken =
                                                true;
                                            safeSetState(() {});
                                          }
                                        }
                                      }),
                                      Future(() async {
                                        if ((_model.workoutPhase ==
                                                WorkoutPhase.Exercise) &&
                                            (FFAppState()
                                                        .cachedAudioExerciseData !=
                                                    null &&
                                                FFAppState()
                                                        .cachedAudioExerciseData !=
                                                    '') &&
                                            ((_model.timerMilliseconds1 >
                                                    10000) &&
                                                (_model.timerMilliseconds1 <=
                                                    11000)) &&
                                            (FFAppState()
                                                    .wasAudioExerciseTaken ==
                                                false)) {
                                          _model.isSpeaking = true;
                                          _model.quoteDisplay =
                                              _model.quoteExercise;
                                          safeSetState(() {});
                                          await actions.playPcmAsWav(
                                            FFAppState()
                                                .cachedAudioExerciseData,
                                          );
                                          await Future.delayed(
                                            Duration(
                                              milliseconds: functions
                                                  .calculateDelay(FFAppState()
                                                      .cachedTextExerciseData),
                                            ),
                                          );
                                          FFAppState().wasAudioExerciseTaken =
                                              true;
                                          safeSetState(() {});
                                          _model.isSpeaking = false;
                                          safeSetState(() {});
                                        }
                                      }),
                                      Future(() async {
                                        if ((_model.workoutPhase ==
                                                WorkoutPhase.LongRest) &&
                                            (FFAppState().cachedAudioRestData !=
                                                    null &&
                                                FFAppState()
                                                        .cachedAudioRestData !=
                                                    '') &&
                                            ((_model.restBetweenCyclesTime! >
                                                    29000) &&
                                                (_model.timerMilliseconds1 >
                                                    19000) &&
                                                (_model.timerMilliseconds1 <=
                                                    20000)) &&
                                            (FFAppState().wasAudioRestTaken ==
                                                false)) {
                                          _model.isSpeaking = true;
                                          _model.quoteDisplay =
                                              _model.quoteRest;
                                          safeSetState(() {});
                                          await actions.playPcmAsWav(
                                            FFAppState().cachedAudioRestData,
                                          );
                                          await Future.delayed(
                                            Duration(
                                              milliseconds: functions
                                                  .calculateDelay(FFAppState()
                                                      .cachedTextRestData),
                                            ),
                                          );
                                          FFAppState().wasAudioRestTaken = true;
                                          safeSetState(() {});
                                          _model.isSpeaking = false;
                                          safeSetState(() {});
                                        }
                                      }),
                                    ]);
                                  } else {
                                    if (animationsMap[
                                            'iconButtonOnActionTriggerAnimation'] !=
                                        null) {
                                      await animationsMap[
                                              'iconButtonOnActionTriggerAnimation']!
                                          .controller
                                        ..reset()
                                        ..repeat();
                                    }
                                  }

                                  safeSetState(() {});
                                },
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                      fontSize: _model.testMode ? 16.0 : 1.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          if (_model.testMode)
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.02),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 150.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    _model.test2,
                                    'test2',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          if (_model.testMode)
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 60.0, 0.0, 0.0),
                                child: Text(
                                  FFAppState().cachedTextExerciseData != null &&
                                          FFAppState().cachedTextExerciseData !=
                                              ''
                                      ? 'text exercise is ready'
                                      : 'text exercise file is empty',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          if (_model.testMode)
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 40.0, 0.0, 0.0),
                                child: Text(
                                  FFAppState().cachedAudioExerciseData !=
                                              null &&
                                          FFAppState()
                                                  .cachedAudioExerciseData !=
                                              ''
                                      ? 'audio exercise is ready'
                                      : 'audio exercise file is empty',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  FFAppState().isPlaying = false;
                                  safeSetState(() {});
                                  _model.currentCycle = 1;
                                  _model.currentExercise = 1;
                                  _model.workoutPhase = WorkoutPhase.Exercise;
                                  safeSetState(() {});
                                  _model.timerController1.timer.setPresetTime(
                                    mSec: _model.exerciseTime!,
                                    add: false,
                                  );
                                  _model.timerController1.onResetTimer();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.replay_sharp,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          size: 40.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  if (FFAppState().isPlaying == true) {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        FFAppState().isPlaying = false;
                                        safeSetState(() {});
                                        _model.timerController1.onStopTimer();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.pause,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                size: 40.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        FFAppState().isPlaying = true;
                                        safeSetState(() {});
                                        _model.timerController1.onStartTimer();
                                        _model.timerController2.onStartTimer();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.play_arrow,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                size: 40.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  var confirmDialogResponse =
                                      await showDialog<bool>(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text('Koniec treningu'),
                                                content: Text(
                                                    'Czy chce zakończyć trening?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            false),
                                                    child: Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            true),
                                                    child: Text('Confirm'),
                                                  ),
                                                ],
                                              );
                                            },
                                          ) ??
                                          false;
                                  if (confirmDialogResponse) {
                                    FFAppState().isPlaying = false;
                                    safeSetState(() {});
                                    _model.timerController1.timer.setPresetTime(
                                      mSec: _model.exerciseTime!,
                                      add: false,
                                    );
                                    _model.timerController1.onResetTimer();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.stop,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          size: 40.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                              .divide(SizedBox(width: 60.0))
                              .addToStart(SizedBox(width: 32.0))
                              .addToEnd(SizedBox(width: 32.0)),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              60.0, 24.0, 60.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    if (_model.isSpeaking == true) {
                                      return Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          _model.quoteDisplay!,
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                                font: GoogleFonts.interTight(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        FFLocalizations.of(context).getText(
                                          '2thazfj5' /*   */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ].addToStart(SizedBox(height: 32.0)),
                  ),
                ].addToStart(SizedBox(height: 30.0)),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(
                                0.0,
                                -2.0,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (FFAppState().assistantMode ==
                                  AssistantMode.Enable)
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (FFAppState()
                                                  .wasAudioExerciseTaken ||
                                              FFAppState().wasAudioRestTaken) {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 4.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'vh31iews' /* Loading sounds */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .robotoSlab(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Lottie.asset(
                                                    'assets/jsons/Cosmos.json',
                                                    width: 40.0,
                                                    height: 40.0,
                                                    fit: BoxFit.contain,
                                                    animate: true,
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '976ih78c' /* Readay to play */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts
                                                            .robotoSlab(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Icon(
                                                  Icons.check_sharp,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .success,
                                                  size: 20.0,
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    if (_model.isSpeaking == true) {
                                      return Visibility(
                                        visible: _model.isSpeaking == true,
                                        child: Lottie.asset(
                                          'assets/jsons/Audio&Voice-A-002.json',
                                          width: 200.0,
                                          height: 40.0,
                                          fit: BoxFit.fitHeight,
                                          animate: true,
                                        ).animateOnPageLoad(animationsMap[
                                            'lottieAnimationOnPageLoadAnimation']!),
                                      );
                                    } else {
                                      return Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'tcvbp3to' /* AI Coach */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .interTight(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .fontStyle,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 8.0, 8.0, 8.0),
                                      child: FlutterFlowIconButton(
                                        borderRadius: 8.0,
                                        buttonSize: 40.0,
                                        fillColor: FFAppState().assistantMode ==
                                                AssistantMode.Disabled
                                            ? FlutterFlowTheme.of(context)
                                                .secondaryText
                                            : FlutterFlowTheme.of(context)
                                                .primary,
                                        icon: Icon(
                                          Icons.power_settings_new,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          FFAppState().assistantMode =
                                              FFAppState().assistantMode ==
                                                      AssistantMode.Disabled
                                                  ? AssistantMode.Enable
                                                  : AssistantMode.Disabled;
                                          safeSetState(() {});
                                          _model.test2 =
                                              FFAppState().assistantMode?.name;
                                          safeSetState(() {});
                                        },
                                      ).animateOnActionTrigger(
                                        animationsMap[
                                            'iconButtonOnActionTriggerAnimation']!,
                                      ),
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(width: 8.0))
                                    .addToStart(SizedBox(width: 8.0))
                                    .addToEnd(SizedBox(width: 8.0)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
