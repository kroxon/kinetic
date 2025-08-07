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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import 'dart:convert';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';

// Deklarujemy odtwarzacz jako zmienną globalną
final pcmPlayer = AudioPlayer();

Future playPcmAsWav(String audioBase64) async {
  if (audioBase64.isEmpty) {
    print("BŁĄD: Otrzymano puste dane audio.");
    return;
  }

  // Dekodujemy surowe dane PCM z Base64
  final pcmData = base64Decode(audioBase64);

  // Tworzymy nagłówek formatu WAV
  // To jest "magia", która zamienia surowe dane w odtwarzalny plik
  final wavData = addWavHeader(pcmData);

  // Odtwarzamy kompletne dane WAV z pamięci
  await pcmPlayer.play(BytesSource(wavData));
}

// Funkcja pomocnicza, która dodaje nagłówek WAV do surowych danych PCM
Uint8List addWavHeader(Uint8List pcmData) {
  const int sampleRate = 24000; // Zgodnie z odpowiedzią API
  const int numChannels = 1;
  const int bitsPerSample = 16;
  const int byteRate = sampleRate * numChannels * bitsPerSample ~/ 8;
  final int pcmDataLength = pcmData.length;
  final int wavDataLength = pcmDataLength + 44; // 44 bajty na nagłówek

  final buffer = ByteData(wavDataLength);
  final writer = buffer.buffer.asUint8List();

  // Nagłówek RIFF
  writer.setAll(0, ascii.encode('RIFF'));
  buffer.setUint32(4, wavDataLength - 8, Endian.little);
  writer.setAll(8, ascii.encode('WAVE'));

  // Format "fmt "
  writer.setAll(12, ascii.encode('fmt '));
  buffer.setUint32(16, 16, Endian.little); // Długość sub-chunka
  buffer.setUint16(20, 1, Endian.little); // Format audio (1 = PCM)
  buffer.setUint16(22, numChannels, Endian.little);
  buffer.setUint32(24, sampleRate, Endian.little);
  buffer.setUint32(28, byteRate, Endian.little);
  buffer.setUint16(32, numChannels * bitsPerSample ~/ 8, Endian.little);
  buffer.setUint16(34, bitsPerSample, Endian.little);

  // Dane "data"
  writer.setAll(36, ascii.encode('data'));
  buffer.setUint32(40, pcmDataLength, Endian.little);
  writer.setAll(44, pcmData);

  return writer;
}
