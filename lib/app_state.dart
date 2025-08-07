import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _myWorkouts = (await secureStorage.getStringList('ff_myWorkouts'))
              ?.map((x) {
                try {
                  return WorkoutStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _myWorkouts;
    });
    await _safeInitAsync(() async {
      _currentWorkoutIndex =
          await secureStorage.getInt('ff_currentWorkoutIndex') ??
              _currentWorkoutIndex;
    });
    await _safeInitAsync(() async {
      _assistantMode = await secureStorage.read(key: 'ff_assistantMode') != null
          ? deserializeEnum<AssistantMode>(
              (await secureStorage.getString('ff_assistantMode')))
          : _assistantMode;
    });
    await _safeInitAsync(() async {
      _geminiApiKey =
          await secureStorage.getString('ff_geminiApiKey') ?? _geminiApiKey;
    });
    await _safeInitAsync(() async {
      _googleTextToSpeachApiKey =
          await secureStorage.getString('ff_googleTextToSpeachApiKey') ??
              _googleTextToSpeachApiKey;
    });
    await _safeInitAsync(() async {
      _pitchGTTS = await secureStorage.getDouble('ff_pitchGTTS') ?? _pitchGTTS;
    });
    await _safeInitAsync(() async {
      _speakingRateGTTS =
          await secureStorage.getDouble('ff_speakingRateGTTS') ??
              _speakingRateGTTS;
    });
    await _safeInitAsync(() async {
      _geminiTTSNativeApiKey =
          await secureStorage.getString('ff_geminiTTSNativeApiKey') ??
              _geminiTTSNativeApiKey;
    });
    await _safeInitAsync(() async {
      _chatTemperature = await secureStorage.getDouble('ff_chatTemperature') ??
          _chatTemperature;
    });
    await _safeInitAsync(() async {
      _topP = await secureStorage.getDouble('ff_topP') ?? _topP;
    });
    await _safeInitAsync(() async {
      _topK = await secureStorage.getInt('ff_topK') ?? _topK;
    });
    await _safeInitAsync(() async {
      _AiTextPromptProperties =
          await secureStorage.getString('ff_AiTextPromptProperties') ??
              _AiTextPromptProperties;
    });
    await _safeInitAsync(() async {
      _AiVoicePromptProperties =
          await secureStorage.getString('ff_AiVoicePromptProperties') ??
              _AiVoicePromptProperties;
    });
    await _safeInitAsync(() async {
      _voices = (await secureStorage.getStringList('ff_voices'))
              ?.map((x) {
                try {
                  return VoicesStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _voices;
    });
    await _safeInitAsync(() async {
      _currentVoiceIndex = await secureStorage.getInt('ff_currentVoiceIndex') ??
          _currentVoiceIndex;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  List<WorkoutStruct> _myWorkouts = [
    WorkoutStruct.fromSerializableMap(jsonDecode(
        '{\"workoutName\":\"Primary\",\"numberOfCycles\":\"3\",\"numberOfExercises\":\"3\",\"exerciseDuration\":\"12\",\"restDuration\":\"8\",\"restBetweenCycles\":\"33\"}')),
    WorkoutStruct.fromSerializableMap(jsonDecode(
        '{\"workoutName\":\"Secondary\",\"numberOfCycles\":\"3\",\"numberOfExercises\":\"4\",\"exerciseDuration\":\"221\",\"restDuration\":\"9\",\"restBetweenCycles\":\"164\"}'))
  ];
  List<WorkoutStruct> get myWorkouts => _myWorkouts;
  set myWorkouts(List<WorkoutStruct> value) {
    _myWorkouts = value;
    secureStorage.setStringList(
        'ff_myWorkouts', value.map((x) => x.serialize()).toList());
  }

  void deleteMyWorkouts() {
    secureStorage.delete(key: 'ff_myWorkouts');
  }

  void addToMyWorkouts(WorkoutStruct value) {
    myWorkouts.add(value);
    secureStorage.setStringList(
        'ff_myWorkouts', _myWorkouts.map((x) => x.serialize()).toList());
  }

  void removeFromMyWorkouts(WorkoutStruct value) {
    myWorkouts.remove(value);
    secureStorage.setStringList(
        'ff_myWorkouts', _myWorkouts.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMyWorkouts(int index) {
    myWorkouts.removeAt(index);
    secureStorage.setStringList(
        'ff_myWorkouts', _myWorkouts.map((x) => x.serialize()).toList());
  }

  void updateMyWorkoutsAtIndex(
    int index,
    WorkoutStruct Function(WorkoutStruct) updateFn,
  ) {
    myWorkouts[index] = updateFn(_myWorkouts[index]);
    secureStorage.setStringList(
        'ff_myWorkouts', _myWorkouts.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMyWorkouts(int index, WorkoutStruct value) {
    myWorkouts.insert(index, value);
    secureStorage.setStringList(
        'ff_myWorkouts', _myWorkouts.map((x) => x.serialize()).toList());
  }

  int _currentWorkoutIndex = 1;
  int get currentWorkoutIndex => _currentWorkoutIndex;
  set currentWorkoutIndex(int value) {
    _currentWorkoutIndex = value;
    secureStorage.setInt('ff_currentWorkoutIndex', value);
  }

  void deleteCurrentWorkoutIndex() {
    secureStorage.delete(key: 'ff_currentWorkoutIndex');
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
  }

  double _progressValue = 1.0;
  double get progressValue => _progressValue;
  set progressValue(double value) {
    _progressValue = value;
  }

  AssistantMode? _assistantMode;
  AssistantMode? get assistantMode => _assistantMode;
  set assistantMode(AssistantMode? value) {
    _assistantMode = value;
    value != null
        ? secureStorage.setString('ff_assistantMode', value.serialize())
        : secureStorage.remove('ff_assistantMode');
  }

  void deleteAssistantMode() {
    secureStorage.delete(key: 'ff_assistantMode');
  }

  String _geminiApiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  String get geminiApiKey => _geminiApiKey;
  set geminiApiKey(String value) {
    _geminiApiKey = value;
    secureStorage.setString('ff_geminiApiKey', value);
  }

  void deleteGeminiApiKey() {
    secureStorage.delete(key: 'ff_geminiApiKey');
  }

  String _googleTextToSpeachApiKey = dotenv.env['GOOGLE_TTS_API_KEY'] ?? '';
  String get googleTextToSpeachApiKey => _googleTextToSpeachApiKey;
  set googleTextToSpeachApiKey(String value) {
    _googleTextToSpeachApiKey = value;
    secureStorage.setString('ff_googleTextToSpeachApiKey', value);
  }

  void deleteGoogleTextToSpeachApiKey() {
    secureStorage.delete(key: 'ff_googleTextToSpeachApiKey');
  }

  double _pitchGTTS = 0.0;
  double get pitchGTTS => _pitchGTTS;
  set pitchGTTS(double value) {
    _pitchGTTS = value;
    secureStorage.setDouble('ff_pitchGTTS', value);
  }

  void deletePitchGTTS() {
    secureStorage.delete(key: 'ff_pitchGTTS');
  }

  double _speakingRateGTTS = 1.0;
  double get speakingRateGTTS => _speakingRateGTTS;
  set speakingRateGTTS(double value) {
    _speakingRateGTTS = value;
    secureStorage.setDouble('ff_speakingRateGTTS', value);
  }

  void deleteSpeakingRateGTTS() {
    secureStorage.delete(key: 'ff_speakingRateGTTS');
  }

  String _geminiTTSNativeApiKey = dotenv.env['GEMINI_TTS_NATIVE_API_KEY'] ?? '';
  String get geminiTTSNativeApiKey => _geminiTTSNativeApiKey;
  set geminiTTSNativeApiKey(String value) {
    _geminiTTSNativeApiKey = value;
    secureStorage.setString('ff_geminiTTSNativeApiKey', value);
  }

  void deleteGeminiTTSNativeApiKey() {
    secureStorage.delete(key: 'ff_geminiTTSNativeApiKey');
  }

  double _chatTemperature = 0.8;
  double get chatTemperature => _chatTemperature;
  set chatTemperature(double value) {
    _chatTemperature = value;
    secureStorage.setDouble('ff_chatTemperature', value);
  }

  void deleteChatTemperature() {
    secureStorage.delete(key: 'ff_chatTemperature');
  }

  double _topP = 0.85;
  double get topP => _topP;
  set topP(double value) {
    _topP = value;
    secureStorage.setDouble('ff_topP', value);
  }

  void deleteTopP() {
    secureStorage.delete(key: 'ff_topP');
  }

  int _topK = 40;
  int get topK => _topK;
  set topK(int value) {
    _topK = value;
    secureStorage.setInt('ff_topK', value);
  }

  void deleteTopK() {
    secureStorage.delete(key: 'ff_topK');
  }

  String _AiTextPromptProperties = '';
  String get AiTextPromptProperties => _AiTextPromptProperties;
  set AiTextPromptProperties(String value) {
    _AiTextPromptProperties = value;
    secureStorage.setString('ff_AiTextPromptProperties', value);
  }

  void deleteAiTextPromptProperties() {
    secureStorage.delete(key: 'ff_AiTextPromptProperties');
  }

  String _AiVoicePromptProperties = '';
  String get AiVoicePromptProperties => _AiVoicePromptProperties;
  set AiVoicePromptProperties(String value) {
    _AiVoicePromptProperties = value;
    secureStorage.setString('ff_AiVoicePromptProperties', value);
  }

  void deleteAiVoicePromptProperties() {
    secureStorage.delete(key: 'ff_AiVoicePromptProperties');
  }

  List<VoicesStruct> _voices = [
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Zephyr\",\"value\":\"Bright\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Korea\",\"value\":\"Firm\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Orus\",\"value\":\"Firm\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Autonoe\",\"value\":\"Bright\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Umbriel\",\"value\":\" Easy-going\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Erinome\",\"value\":\"Clear\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Laomedeia\",\"value\":\"Upbeat\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Schedar\",\"value\":\"Even\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Achird\",\"value\":\"Friendly\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Sadachbia\",\"value\":\"Lively\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Puck\",\"value\":\"Upbeat\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Fenrir\",\"value\":\"Excitable\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Aoede\",\"value\":\"Aoede\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Enceladus\",\"value\":\"Breathy\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Algieba\",\"value\":\"Smooth\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Algenib\",\"value\":\"Gravelly\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Achernar\",\"value\":\"Soft\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Gacrux\",\"value\":\"Mature\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Zubenelgenubi\",\"value\":\"Casual\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Sadaltager\",\"value\":\"Knowledgeable\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Charon\",\"value\":\"Informative\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Leda\",\"value\":\"Youthful\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Callirrhoe\",\"value\":\"Easy-going\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Iapetus\",\"value\":\"Clear\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Despina\",\"value\":\"Smooth\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Rasalgethi\",\"value\":\"Informative\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Alnilam\",\"value\":\"Firm\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Pulcherrima\",\"value\":\"Forward\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Vindemiatrix\",\"value\":\"Gentle\"}')),
    VoicesStruct.fromSerializableMap(
        jsonDecode('{\"label\":\"Sulafat\",\"value\":\"Warm\"}'))
  ];
  List<VoicesStruct> get voices => _voices;
  set voices(List<VoicesStruct> value) {
    _voices = value;
    secureStorage.setStringList(
        'ff_voices', value.map((x) => x.serialize()).toList());
  }

  void deleteVoices() {
    secureStorage.delete(key: 'ff_voices');
  }

  void addToVoices(VoicesStruct value) {
    voices.add(value);
    secureStorage.setStringList(
        'ff_voices', _voices.map((x) => x.serialize()).toList());
  }

  void removeFromVoices(VoicesStruct value) {
    voices.remove(value);
    secureStorage.setStringList(
        'ff_voices', _voices.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromVoices(int index) {
    voices.removeAt(index);
    secureStorage.setStringList(
        'ff_voices', _voices.map((x) => x.serialize()).toList());
  }

  void updateVoicesAtIndex(
    int index,
    VoicesStruct Function(VoicesStruct) updateFn,
  ) {
    voices[index] = updateFn(_voices[index]);
    secureStorage.setStringList(
        'ff_voices', _voices.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInVoices(int index, VoicesStruct value) {
    voices.insert(index, value);
    secureStorage.setStringList(
        'ff_voices', _voices.map((x) => x.serialize()).toList());
  }

  int _currentVoiceIndex = 0;
  int get currentVoiceIndex => _currentVoiceIndex;
  set currentVoiceIndex(int value) {
    _currentVoiceIndex = value;
    secureStorage.setInt('ff_currentVoiceIndex', value);
  }

  void deleteCurrentVoiceIndex() {
    secureStorage.delete(key: 'ff_currentVoiceIndex');
  }

  String _cachedAudioExerciseData = '';
  String get cachedAudioExerciseData => _cachedAudioExerciseData;
  set cachedAudioExerciseData(String value) {
    _cachedAudioExerciseData = value;
  }

  String _cachedTextExerciseData = '';
  String get cachedTextExerciseData => _cachedTextExerciseData;
  set cachedTextExerciseData(String value) {
    _cachedTextExerciseData = value;
  }

  bool _wasAudioExerciseTaken = true;
  bool get wasAudioExerciseTaken => _wasAudioExerciseTaken;
  set wasAudioExerciseTaken(bool value) {
    _wasAudioExerciseTaken = value;
  }

  bool _wasTextExerciseTaken = true;
  bool get wasTextExerciseTaken => _wasTextExerciseTaken;
  set wasTextExerciseTaken(bool value) {
    _wasTextExerciseTaken = value;
  }

  String _cachedAudioRestData = '';
  String get cachedAudioRestData => _cachedAudioRestData;
  set cachedAudioRestData(String value) {
    _cachedAudioRestData = value;
  }

  String _cachedTextRestData = '';
  String get cachedTextRestData => _cachedTextRestData;
  set cachedTextRestData(String value) {
    _cachedTextRestData = value;
  }

  bool _wasAudioRestTaken = true;
  bool get wasAudioRestTaken => _wasAudioRestTaken;
  set wasAudioRestTaken(bool value) {
    _wasAudioRestTaken = value;
  }

  bool _wasTextRestTaken = true;
  bool get wasTextRestTaken => _wasTextRestTaken;
  set wasTextRestTaken(bool value) {
    _wasTextRestTaken = value;
  }

  String _testText = 'test 1';
  String get testText => _testText;
  set testText(String value) {
    _testText = value;
  }

  String _cachedStyleExerciseData = '';
  String get cachedStyleExerciseData => _cachedStyleExerciseData;
  set cachedStyleExerciseData(String value) {
    _cachedStyleExerciseData = value;
  }

  String _cachedStyleRestData = '';
  String get cachedStyleRestData => _cachedStyleRestData;
  set cachedStyleRestData(String value) {
    _cachedStyleRestData = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
