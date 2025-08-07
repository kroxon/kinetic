import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GoogleCloudTTSCall {
  static Future<ApiCallResponse> call({
    String? inputText = '',
    String? apiKey = '',
    String? languageCode = 'pl-PL',
    String? voiceName = 'pl-PL-Standard-G',
    double? speakingRate = 1.0,
    double? pitch = 0.0,
  }) async {
    final ffApiRequestBody = '''
{
  "input": {
    "text": "${escapeStringForJson(inputText)}"
  },
  "voice": {
    "languageCode": "${escapeStringForJson(languageCode)}",
    "name": "${escapeStringForJson(voiceName)}"
  },
  "audioConfig": {
    "audioEncoding": "MP3",
    "speakingRate": ${speakingRate},
    "pitch": ${pitch}
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GoogleCloudTTS',
      apiUrl:
          'https://texttospeech.googleapis.com/v1/text:synthesize?key=${apiKey}',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GeminiGenerateTextCall {
  static Future<ApiCallResponse> call({
    String? apiKey = '',
    String? userPrompt = '',
    double? temperature = 1.0,
    double? topP = 0.85,
    int? maxOutputTokens = 3000,
  }) async {
    final ffApiRequestBody = '''
{
  "contents": [
    {
      "parts": [
        {
          "text": "${escapeStringForJson(userPrompt)}"
        }
      ]
    }
  ],
  "generationConfig": {
    "temperature": ${temperature},
    "topP": ${topP},
    "maxOutputTokens": ${maxOutputTokens}
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GeminiGenerateText',
      apiUrl:
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'x-goog-api-key': '${apiKey}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? generatedText(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.candidates[0].content.parts[0].text''',
      ));
}

class GoogleTTSNativeCall {
  static Future<ApiCallResponse> call({
    String? apiKey = '',
    String? userPrompt = '',
    String? voiceName = 'Kore',
  }) async {
    final ffApiRequestBody = '''
{
  "contents": [
    {
      "parts": [
        {
          "text": "${escapeStringForJson(userPrompt)}"
        }
      ]
    }
  ],
  "generationConfig": {
    "responseModalities": ["AUDIO"],
    "speechConfig": {
      "voiceConfig": {
        "prebuiltVoiceConfig": {
          "voiceName": "${escapeStringForJson(voiceName)}"
        }
      }
    }
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GoogleTTSNative',
      apiUrl:
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-tts:generateContent',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'x-goog-api-key': '${apiKey}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? audioResult(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.candidates[:].content.parts[:].inlineData.data''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
