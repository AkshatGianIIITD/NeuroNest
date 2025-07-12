import 'package:flutter/material.dart';
import 'package:neuronest_flutter_frontend/theme/colors.dart';

class HomeOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const HomeOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryGray,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 40, color: AppColors.primaryTeal),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textGray,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: AppColors.textGray),
          ],
        ),
      ),
    );
  }
}