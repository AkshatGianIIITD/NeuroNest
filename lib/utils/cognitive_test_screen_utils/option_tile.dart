import 'package:flutter/material.dart';
import 'package:neuronest_flutter_frontend/theme/colors.dart';

class OptionTile extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;
  const OptionTile(
      {super.key,
      required this.optionText,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.highlightLilac : AppColors.secondaryGray,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryTeal : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: AppColors.primaryTeal,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                optionText,
                style: const TextStyle(fontSize: 18, color: AppColors.textDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
