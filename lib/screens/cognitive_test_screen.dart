import 'package:flutter/material.dart';
import 'package:neuronest_flutter_frontend/theme/colors.dart';
import 'package:neuronest_flutter_frontend/utils/cognitive_test_screen_utils/next_button.dart';
import 'package:neuronest_flutter_frontend/utils/cognitive_test_screen_utils/option_tile.dart';

class CognitiveTestScreen extends StatefulWidget {
  List<double> cognitiveTestScreenResults = [];

  CognitiveTestScreen({
    super.key,
    required this.cognitiveTestScreenResults,
  });

  @override
  State<CognitiveTestScreen> createState() => _CognitiveTestScreenState();
}

class _CognitiveTestScreenState extends State<CognitiveTestScreen> {
  int questionIndex = 0;
  int selectedOption = -1;

  double correctAnswerCount = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the current day, date, and year?',
      'options': [
        'Monday, April 14, 2025',
        'Tuesday, April 14, 2025',
        'Sunday, April 13, 2025',
        'Monday, April 13, 2025'
      ],
      'answer': 0, //answers are indices
    },
    {
      'question': 'Where are do you go to buy cloths?',
      'options': [
        'At a hospital',
        'At home',
        'At a shopping mal',
        'I’m not sure'
      ],
      'answer': 2,
    },
    {
      'instructions': 'You are told three words: “Apple, Table, Penny.”',
      'question': 'Which of the following was not in the original list?',
      'options': ['Apple', 'Table', 'Penny', 'Chair'],
      'answer': 3,
    },
    {
      'question':
          'Subtract 7 from 100, then subtract 7 again. What is the second result?',
      'options': ['93', '86', '85', '87'],
      'answer': 1,
    },
    {
      'instructions':
          'Repeat this sentence in your mind:"The cat always hid under the couch when the dogs were in the room."',
      'question': 'Which phrase best matches the original sentence?',
      'options': [
        'The cat ran when the dog came',
        'The cat hid when the dogs were near',
        'The cat always hid under the couch when the dogs were in the room',
        'The cat never stayed in the room with dogs'
      ],
      'answer': 2,
    },
    {
      'question': 'How are an orange and a banana alike?',
      'options': [
        'Both are fruits',
        'Both are yellow',
        'Both are round',
        'Both grow on trees'
      ],
      'answer': 0,
    },
    {
      'question': 'Choose the option that is not a type of animal:',
      'options': ['Elephant', 'Dolphin', 'Zipper', 'Kangaroo'],
      'answer': 2,
    },
    {
      'question': 'What were the three words given to you earlier?',
      'options': [
        'Table, Penny, Chair',
        'Apple, Table, Penny',
        'Apple, Coin, Bed',
        'Book, Chair, Apple'
      ],
      'answer': 1,
    },
    {
      'question': 'Which shape is a mirror image of this shape → ⅃ ?',
      'options': ['⅃', 'L', '┘', 'J'],
      'answer': 1,
    },
    {
      'question':
          'You find a stamped, addressed envelope on the ground. What should you do?',
      'options': [
        'Open it to check its contents',
        'Throw it away',
        'Drop it at the nearest mailbox',
        'Leave it on the ground'
      ],
      'answer': 2,
    },
  ];

  void goToNext() {
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        selectedOption = -1;
      });
    } else {
      widget.cognitiveTestScreenResults.add(correctAnswerCount);
      // TODO: Navigate to result screen or show final score
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Test Completed")),
      );
      Navigator.pop(context); // or navigate to summary
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = questions[questionIndex];
    final progress = (questionIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Cognitive Test'),
        backgroundColor: AppColors.primaryTeal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: progress,
                color: AppColors.primaryTeal,
                backgroundColor: AppColors.secondaryGray,
                minHeight: 8,
              ),
              const SizedBox(height: 20),
              Text(
                'Question ${questionIndex + 1}/${questions.length}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (currentQ.containsKey('instructions'))
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    currentQ['instructions'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: AppColors.textDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              Text(
                currentQ['question'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ...List.generate(currentQ['options'].length, (index) {
                final option = currentQ['options'][index];
                final isSelected = index == selectedOption;

                return OptionTile(
                  optionText: option,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedOption = index;

                      //Correct answer count
                      if (index == currentQ['answer']) {
                        correctAnswerCount += 0.1;
                      }
                    });
                  },
                );
              }),
              const SizedBox(height: 30),
              NextButton(
                selectedOption: selectedOption,
                questionIndex: questionIndex,
                questionsLength: questions.length,
                onNext: selectedOption == -1 ? null : goToNext,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
