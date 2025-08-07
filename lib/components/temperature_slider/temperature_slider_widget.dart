import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'temperature_slider_model.dart';
export 'temperature_slider_model.dart';

/// Poziomy slider ustawiający wartość od 0.0 do 2.0 ze skokiem 0.1
///
/// Nad sliderem pokaż aktualną wartość z zaokrągleniem do 1 miejsca po
/// przecinku
///
/// Kolor suwaka zmienia się dynamicznie w zależności od wartości:
///
/// 0.0 = niebieski (Colors.blue)
///
/// 1.0 = fioletowy (Colors.purple)
///
/// 2.0 = czerwony (Colors.red)
///
/// Użyj Color.lerp() do płynnego przejścia między tymi kolorami
///
/// Wynik zapisywany do zmiennej lokalnej komponentu (double temperature)
///
/// Komponent ma być stylowo prosty, nowoczesny, bez ramek i paddingu
///
/// Kolory mają być statyczne (niezależne od dark/light mode)
///
/// Użyj Slider.adaptive jeśli pasuje do wyglądu
class TemperatureSliderWidget extends StatefulWidget {
  const TemperatureSliderWidget({super.key});

  @override
  State<TemperatureSliderWidget> createState() =>
      _TemperatureSliderWidgetState();
}

class _TemperatureSliderWidgetState extends State<TemperatureSliderWidget> {
  late TemperatureSliderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TemperatureSliderModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              child: Slider(
                activeColor: Colors.purple,
                inactiveColor: Color(0xFFE1BEE7),
                min: 0.0,
                max: 2.0,
                value: _model.sliderValue ??= 1.0,
                onChanged: (newValue) {
                  newValue = double.parse(newValue.toStringAsFixed(4));
                  safeSetState(() => _model.sliderValue = newValue);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
