
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neuronest_flutter_frontend/theme/colors.dart';

Future<double?> callNeuronestAPI(String inputText) async {
  final postUrl =
      'https://lanuuk-neuronest-space.hf.space/gradio_api/call/predict';

  try {
    final response = await http.post(
      Uri.parse(postUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"data": [inputText]}),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final String eventId = jsonResponse['event_id'] ?? "";
      if (eventId.isEmpty) return null;

      for (int i = 0; i < 10; i++) {
        await Future.delayed(Duration(seconds: 1));
        final resultUrl =
            'https://lanuuk-neuronest-space.hf.space/gradio_api/call/predict/$eventId';
        final resultResponse = await http.get(Uri.parse(resultUrl));

        try {
          String raw = resultResponse.body.split(":")[3].trim();
          raw = raw.replaceAll(RegExp(r'[^0-9.]'), '');
          double percentage = double.parse(raw);
          return percentage;
        } catch (_) {}
      }
    }
  } catch (e) {
    print("Error: $e");
  }
  return null;
}

class VoiceTestScreen extends StatefulWidget {
  final List<double> speechTestScreenResults; 
  const VoiceTestScreen({super.key, required this.speechTestScreenResults});

  @override
  State<VoiceTestScreen> createState() => _VoiceTestScreenState();
}

class _VoiceTestScreenState extends State<VoiceTestScreen> {
  final List<Map<String, String>> questionItems = [
    {"text": "Can you tell me what you did yesterday?"},
    {"text": "Talk about your family."},
    {"text": "Describe your favorite meal."},
    {"text": "Tell me about your childhood memories."},
    {"image": 'assets/img/cart_balloons.jpg'},
    {"image": 'assets/img/couple.jpg'},
    {"image": 'assets/img/dog_frisbee.jpg'},
    {"image": 'assets/img/kid_puppy.jpg'},
    {"image": 'assets/img/kids_bicycle.jpg'},
    {"image": 'assets/img/kids.jpg'},
    {"image": 'assets/img/old_people_picnic.jpg'},
    {"image": 'assets/img/old_woman_pegions.jpg'},
    {"image": 'assets/img/painter.jpg'},
    {"image": 'assets/img/running.jpg'},
  ];

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Press the mic to answer...";
  int _currentIndex = 0;
  List<double?> confidenceScores = [];


  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    confidenceScores = List.filled(questionItems.length, null);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) async {
            setState(() => _text = val.recognizedWords);
            if (val.finalResult) {
              final result = await callNeuronestAPI(_text);
              if (result != null) {
                setState(() {
                  confidenceScores[_currentIndex] = result;
                });
              }
              setState(() => _isListening = false);
              _speech.stop();
            }
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _nextQuestion() {
    if (_currentIndex < questionItems.length - 1) {
      setState(() {
        _currentIndex++;
        _text = questionItems[_currentIndex].containsKey("text")
            ? "Press the mic to answer..."
            : "Describe what you see in the image.";
      });
    }
    else{
      widget.speechTestScreenResults.add(confidenceScores.whereType<double>().average);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Test Completed")),
      );
      Navigator.pop(context);
    }
  }

  void _prevQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _text = questionItems[_currentIndex].containsKey("text")
            ? "Press the mic to answer..."
            : "Describe what you see in the image.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = questionItems[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text("Voice Screening Test"),
        backgroundColor: AppColors.primaryTeal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Question ${_currentIndex + 1} of ${questionItems.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (currentItem.containsKey("text"))
              Text(
                currentItem["text"]!,
                style: const TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              )
            else if (currentItem.containsKey("image"))
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  currentItem["image"]!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _text,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              confidenceScores[_currentIndex] != null
                  ? "Speech recorded. Move to the next question"
                  : "No confidence score yet.",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _prevQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.arrow_back, color: Colors.white),
                      SizedBox(width: 4),
                      Text("Back", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                FloatingActionButton(
                  onPressed: _listen,
                  backgroundColor: AppColors.primaryTeal,
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    size: 28,
                  ),
                ),
                ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                  ),
                  child: Row(
                    children: const [
                      Text("Next", style: TextStyle(color: Colors.white)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

