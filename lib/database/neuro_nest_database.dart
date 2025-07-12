import 'package:hive_flutter/hive_flutter.dart';

class NeuroNestDatabase {
  List<double> cognitiveTestScreenResults = [];
  List<double> speechTestScreenResults = [];

  final _mybox = Hive.box('NeuroNest');

  void createIntialCognitiveData() {
    cognitiveTestScreenResults = [];
  }

  void createIntialSpeechData() {
    speechTestScreenResults = [];
  }

  void loadCognitiveData() {
    cognitiveTestScreenResults = _mybox.get("COGNITIVETESTSCREENRESULTS");
  }

  void loadSpeechData() {
    speechTestScreenResults = _mybox.get('SPEECHTESTSCREENRESULTS');
  }

  void updateDatabase() {
    _mybox.put("COGNITIVETESTSCREENRESULTS", cognitiveTestScreenResults);
    _mybox.put('SPEECHTESTSCREENRESULTS', speechTestScreenResults);
  }
}
