import 'package:flutter/material.dart';
import 'package:neuronest_flutter_frontend/theme/colors.dart';




class NextButton extends StatelessWidget {
  int selectedOption;
  int questionIndex;
  int questionsLength;
  VoidCallback? onNext;
  NextButton({super.key, required this.selectedOption, required this.questionIndex, required this.questionsLength, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryTeal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            );
  }
}