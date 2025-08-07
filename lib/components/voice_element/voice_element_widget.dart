import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'voice_element_model.dart';
export 'voice_element_model.dart';

class VoiceElementWidget extends StatefulWidget {
  const VoiceElementWidget({
    super.key,
    required this.index,
  });

  final int? index;

  @override
  State<VoiceElementWidget> createState() => _VoiceElementWidgetState();
}

class _VoiceElementWidgetState extends State<VoiceElementWidget> {
  late VoiceElementModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VoiceElementModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        FFAppState().currentVoiceIndex = widget!.index!;
        safeSetState(() {});
        await Future.delayed(
          Duration(
            milliseconds: 200,
          ),
        );
        context.safePop();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            width: 1.0,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional(1.0, 0.0),
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    valueOrDefault<String>(
                      FFAppState()
                          .voices
                          .elementAtOrNull(widget!.index!)
                          ?.label,
                      'Kera',
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    valueOrDefault<String>(
                      FFAppState()
                          .voices
                          .elementAtOrNull(widget!.index!)
                          ?.value,
                      'Firm',
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelSmall.fontStyle,
                        ),
                  ),
                ),
              ],
            ),
            if (widget!.index == FFAppState().currentVoiceIndex)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                child: Icon(
                  Icons.check,
                  color: FlutterFlowTheme.of(context).success,
                  size: 32.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
