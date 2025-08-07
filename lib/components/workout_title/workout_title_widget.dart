import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'workout_title_model.dart';
export 'workout_title_model.dart';

class WorkoutTitleWidget extends StatefulWidget {
  const WorkoutTitleWidget({
    super.key,
    required this.index,
    required this.onDeleteAction,
    required this.onEditAction,
  });

  final int? index;
  final Future Function()? onDeleteAction;
  final Future Function()? onEditAction;

  @override
  State<WorkoutTitleWidget> createState() => _WorkoutTitleWidgetState();
}

class _WorkoutTitleWidgetState extends State<WorkoutTitleWidget> {
  late WorkoutTitleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WorkoutTitleModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    valueOrDefault<String>(
                      FFAppState()
                          .myWorkouts
                          .elementAtOrNull(widget!.index!)
                          ?.workoutName,
                      'Test',
                    ),
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          color:
                              widget!.index == FFAppState().currentWorkoutIndex
                                  ? FlutterFlowTheme.of(context).primaryText
                                  : FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                ),
              ),
              FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.edit,
                  color: widget!.index == FFAppState().currentWorkoutIndex
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).secondaryText,
                  size: 28.0,
                ),
                onPressed: () async {
                  context.pushNamed(
                    WorkoutPageWidget.routeName,
                    queryParameters: {
                      'isEditing': serializeParam(
                        true,
                        ParamType.bool,
                      ),
                      'index': serializeParam(
                        widget!.index,
                        ParamType.int,
                      ),
                    }.withoutNulls,
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.leftToRight,
                      ),
                    },
                  );
                },
              ),
              FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.delete_outline,
                  color: widget!.index == FFAppState().currentWorkoutIndex
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).secondaryText,
                  size: 28.0,
                ),
                onPressed: () async {
                  var confirmDialogResponse = await showDialog<bool>(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Delete Workout'),
                            content: Text(
                                'Are you sure you want to delete ${FFAppState().myWorkouts.elementAtOrNull(widget!.index!)?.workoutName}?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, true),
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      ) ??
                      false;
                  if (confirmDialogResponse) {
                    if (FFAppState().myWorkouts.length.toString() == '1') {
                      FFAppState().addToMyWorkouts(WorkoutStruct(
                        workoutName: 'Workout',
                        numberOfCycles: 3,
                        numberOfExercises: 5,
                        exerciseDuration: 21,
                        shortRest: 7,
                        longRest: 61,
                      ));
                      FFAppState().update(() {});
                    }
                    FFAppState().removeFromMyWorkouts(FFAppState()
                        .myWorkouts
                        .elementAtOrNull(widget!.index!)!);
                    FFAppState().currentWorkoutIndex = 0;
                    FFAppState().update(() {});
                  }
                  await widget.onDeleteAction?.call();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
