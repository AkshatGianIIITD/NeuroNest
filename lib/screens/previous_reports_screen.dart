import 'package:flutter/material.dart';
import '../theme/colors.dart';

class PreviousReportsScreen extends StatelessWidget {
  const PreviousReportsScreen({super.key});

  final List<Map<String, String>> reports = const [
    {
      'date': '2025-04-15',
      'type': 'Cognitive Test',
      'result': 'Mild Impairment Detected'
    },
    {
      'date': '2025-04-14',
      'type': 'Voice Screening',
      'result': 'No Signs of Decline'
    },
    {
      'date': '2025-04-12',
      'type': 'Typing Test',
      'result': 'Low accuracy & slow response time'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        title: const Text('Previous Reports'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: reports.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final report = reports[index];
          return Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report['date'] ?? '',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                const SizedBox(height: 8),
                Text(
                  report['type'] ?? '',
                  style: const TextStyle(fontSize: 14, color: AppColors.textDark),
                ),
                const SizedBox(height: 8),
                Text(
                  report['result'] ?? '',
                  style: const TextStyle(fontSize: 14, color: AppColors.primaryTeal),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}