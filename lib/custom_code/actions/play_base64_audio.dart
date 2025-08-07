// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// ... (nie zmieniaj tej sekcji) ...

import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

// Używamy globalnego odtwarzacza
final player = AudioPlayer();

Future playBase64Audio(String audioBase64) async {
  // 1. Sprawdzamy, czy w ogóle coś dostaliśmy
  print('--- Akcja playBase64Audio uruchomiona! ---');
  if (audioBase64.isEmpty) {
    print('KRYTYCZNY BŁĄD: Dane audio są PUSTE!');
    return;
  }
  print('Otrzymano dane. Długość: ${audioBase64.length} znaków.');

  // 2. Próbujemy zdekodować dane (NAJBARDZIEJ PRAWDOPODOBNE MIEJSCE BŁĘDU)
  try {
    final audioBytes = base64Decode(audioBase64);
    print(
        'SUKCES: Dekodowanie Base64 powiodło się! Mamy ${audioBytes.length} bajtów danych.');

    // 3. Jeśli dekodowanie się udało, próbujemy odtworzyć
    try {
      await player.play(BytesSource(audioBytes));
      print('SUKCES: Polecenie odtwarzania wydane do odtwarzacza!');
    } catch (e) {
      print(
          'KRYTYCZNY BŁĄD ODTWARZACZA: Nie udało się odtworzyć zdekodowanych danych. Błąd: $e');
    }
  } catch (e) {
    print(
        'KRYTYCZNY BŁĄD DEKODOWANIA: Nie udało się przekonwertować tekstu na dźwięk. Błąd: $e');
  }
}
