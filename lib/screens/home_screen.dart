// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:neuronest_flutter_frontend/database/neuro_nest_database.dart';
// import 'package:neuronest_flutter_frontend/screens/cognitive_test_screen.dart';
// import 'package:neuronest_flutter_frontend/screens/previous_reports_screen.dart';
// import 'package:neuronest_flutter_frontend/screens/speech_input_screen.dart';
// import 'package:neuronest_flutter_frontend/theme/colors.dart';
// import 'package:neuronest_flutter_frontend/utils/home_screen_utils/home_option_card.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   var _mybox = Hive.box('NeuroNest');
//   NeuroNestDatabase db = NeuroNestDatabase();

//   @override
//   void initState() {
//     if (_mybox.get("COGNITIVETESTSCREENRESULTS") == null) {
//       db.createIntialCognitiveData();
//     } else {
//       db.loadCognitiveData();
//     }

//     if (_mybox.get('SPEECHTESTSCREENRESULTS') == null) {
//       db.createIntialSpeechData();
//     } else {
//       db.loadSpeechData();
//     }

//     print("Cognitive results: ${db.cognitiveTestScreenResults}");
//     print("Speech results: ${db.speechTestScreenResults}");

//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundLight,
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryTeal,
//         title: const Text(
//           'NeuroNest',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Welcome Back!',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textDark,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'What would you like to do today?',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: AppColors.textGray,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               HomeOptionCard(
//                 icon: Icons.psychology_alt,
//                 title: 'Take Cognitive Test',
//                 subtitle: 'MMSE-style memory & attention test',
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => CognitiveTestScreen(
//                                 cognitiveTestScreenResults:
//                                     db.cognitiveTestScreenResults,
//                               ))).then((_) {
//                     setState(() {
//                       print(db.cognitiveTestScreenResults);
//                       db.updateDatabase();
//                     }); // triggers UI rebuild when back from test screen
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               HomeOptionCard(
//                 icon: Icons.mic,
//                 title: 'Voice Screening',
//                 subtitle: 'Analyze speech for cognitive decline',
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => VoiceTestScreen(
//                                 speechTestScreenResults:
//                                     db.speechTestScreenResults,
//                               ))).then((_) {
//                     setState(() {
//                       print(db.speechTestScreenResults);
//                       db.updateDatabase();
//                     }); // triggers UI rebuild when back from test screen
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               HomeOptionCard(
//                 icon: Icons.history,
//                 title: 'Previous Reports',
//                 subtitle: 'View your cognitive score history',
//                 onTap: () {
//                   Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => PreviousReportsScreen()))
//                       .then((_) {
//                     setState(
//                         () {}); // triggers UI rebuild when back from test screen
//                   });
//                 },
//               ),

//               //Graphs
//               const SizedBox(height: 30),
//               Text(
//                 'Cognitive Test Confidence Over Time',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textDark,
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 child: LineChart(
//                   LineChartData(
//                     titlesData: FlTitlesData(
//                       leftTitles: AxisTitles(
//                         sideTitles: SideTitles(showTitles: true),
//                       ),
//                       bottomTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                           showTitles: true,
//                           getTitlesWidget: (value, meta) =>
//                               Text('T${value.toInt()}'),
//                         ),
//                       ),
//                     ),
//                     lineBarsData: [
//                       LineChartBarData(
//                         spots: List.generate(
//                           db.cognitiveTestScreenResults.length,
//                           (i) => FlSpot(
//                               i.toDouble(), db.cognitiveTestScreenResults[i]),
//                         ),
//                         isCurved: true,
//                         color: Colors.blueAccent,
//                         dotData: FlDotData(show: true),
//                         belowBarData: BarAreaData(
//                             show: true,
//                             color: Colors.blueAccent.withOpacity(0.3)),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Speech Test Confidence Over Time',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textDark,
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 child: LineChart(
//                   LineChartData(
//                     titlesData: FlTitlesData(
//                       leftTitles: AxisTitles(
//                         sideTitles: SideTitles(showTitles: true),
//                       ),
//                       bottomTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                           showTitles: true,
//                           getTitlesWidget: (value, meta) =>
//                               Text('T${value.toInt()}'),
//                         ),
//                       ),
//                     ),
//                     lineBarsData: [
//                       LineChartBarData(
//                         spots: List.generate(
//                           db.speechTestScreenResults.length,
//                           (i) =>
//                               FlSpot(i.toDouble(), db.speechTestScreenResults[i]),
//                         ),
//                         isCurved: true,
//                         color: Colors.green,
//                         dotData: FlDotData(show: true),
//                         belowBarData: BarAreaData(
//                             show: true, color: Colors.green.withOpacity(0.3)),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:neuronest_flutter_frontend/database/neuro_nest_database.dart';
import 'package:neuronest_flutter_frontend/screens/cognitive_test_screen.dart';
import 'package:neuronest_flutter_frontend/screens/previous_reports_screen.dart';
import 'package:neuronest_flutter_frontend/screens/speech_input_screen.dart';
import 'package:neuronest_flutter_frontend/theme/colors.dart';
import 'package:neuronest_flutter_frontend/utils/home_screen_utils/home_option_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _mybox = Hive.box('NeuroNest');
  NeuroNestDatabase db = NeuroNestDatabase();

  @override
  void initState() {
    if (_mybox.get("COGNITIVETESTSCREENRESULTS") == null) {
      db.createIntialCognitiveData();
    } else {
      db.loadCognitiveData();
    }

    if (_mybox.get('SPEECHTESTSCREENRESULTS') == null) {
      db.createIntialSpeechData();
    } else {
      db.loadSpeechData();
    }

    print("Cognitive results: ${db.cognitiveTestScreenResults}");
    print("Speech results: ${db.speechTestScreenResults}");

    super.initState();
  }

  // Widget buildLineChart(String title, List<double> values, Color color) {
  //   return values.isEmpty
  //       ? Center(child: Text("No data yet"))
  //       : Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //                 color: AppColors.textDark,
  //               ),
  //             ),
  //             SizedBox(height: 20,),
  //             SizedBox(
  //                 height: 200,
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(top: 8.0),
  //                   child: LineChart(
  //                     LineChartData(
  //                       gridData: FlGridData(show: false),
  //                       borderData: FlBorderData(show: false),
  //                       titlesData: FlTitlesData(
  //                         leftTitles: AxisTitles(
  //                           axisNameWidget: Padding(
  //                             padding: const EdgeInsets.only(left: 50, bottom: 10),
  //                             child: const Text(
  //                               'Dementia Risk',
  //                               style: TextStyle(
  //                                   fontSize: 14, fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                           axisNameSize: 28,
  //                           sideTitles: SideTitles(
  //                             showTitles: true,
  //                             getTitlesWidget: (val, _) => Text(
  //                               val.toStringAsFixed(1),
  //                               style: TextStyle(
  //                                   fontSize: 12, color: AppColors.textDark),
  //                             ),
  //                           ),
  //                         ),
  //                         bottomTitles: AxisTitles(
  //                           axisNameWidget: Padding(
  //                             padding: const EdgeInsets.only(left:40),
  //                             child: const Text(
  //                               'Time',
  //                               style: TextStyle(
  //                                   fontSize: 14, fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                           axisNameSize: 28,
  //                           sideTitles: SideTitles(
  //                             showTitles: true,
  //                             interval: 1,
  //                             getTitlesWidget: (value, _) {
  //                               if (value.toInt() == value &&
  //                                   value.toInt() >= 0 &&
  //                                   value.toInt() < values.length) {
  //                                 return Text(
  //                                   'T${value.toInt()}',
  //                                   style: TextStyle(
  //                                       fontSize: 12,
  //                                       color: AppColors.textDark),
  //                                 );
  //                               }
  //                               return const SizedBox.shrink();
  //                             },
  //                           ),
  //                         ),
  //                         topTitles: AxisTitles(
  //                             sideTitles: SideTitles(showTitles: false)),
  //                         rightTitles: AxisTitles(
  //                             sideTitles: SideTitles(showTitles: false)),
  //                       ),
  //                       lineBarsData: [
  //                         LineChartBarData(
  //                           spots: List.generate(
  //                             values.length,
  //                             (i) => FlSpot(i.toDouble(), values[i]),
  //                           ),
  //                           isCurved: true,
  //                           color: color,
  //                           dotData: FlDotData(show: true),
  //                           belowBarData: BarAreaData(
  //                             show: true,
  //                             color: color.withOpacity(0.3),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 )),
  //             const SizedBox(height: 20),
  //           ],
  //         );
  // }

  Widget buildLineChart(String title, List<double> values, Color color) {
  return values.isEmpty
      ? Center(child: Text("No data yet"))
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300, // Increased height here
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        axisNameWidget: Padding(
                          padding: const EdgeInsets.only(left: 50, bottom: 10),
                          child: const Text(
                            'Dementia Risk',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        axisNameSize: 28,
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (val, _) => Text(
                            val.toStringAsFixed(1),
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textDark),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        axisNameWidget: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: const Text(
                            'Time',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        axisNameSize: 28,
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, _) {
                            if (value.toInt() == value &&
                                value.toInt() >= 0 &&
                                value.toInt() < values.length) {
                              return Text(
                                'T${value.toInt()}',
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.textDark),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(
                          values.length,
                          (i) => FlSpot(i.toDouble(), values[i]),
                        ),
                        isCurved: true,
                        color: color,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color: color.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        title: const Text(
          'NeuroNest',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'What would you like to do today?',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textGray,
              ),
            ),
            const SizedBox(height: 30),
            HomeOptionCard(
              icon: Icons.psychology_alt,
              title: 'Take Cognitive Test',
              subtitle: 'MMSE-style memory & attention test',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CognitiveTestScreen(
                              cognitiveTestScreenResults:
                                  db.cognitiveTestScreenResults,
                            ))).then((_) {
                  setState(() {
                    db.updateDatabase();
                  });
                });
              },
            ),
            const SizedBox(height: 20),
            HomeOptionCard(
              icon: Icons.mic,
              title: 'Voice Screening',
              subtitle: 'Analyze speech for cognitive decline',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VoiceTestScreen(
                              speechTestScreenResults:
                                  db.speechTestScreenResults,
                            ))).then((_) {
                  setState(() {
                    db.updateDatabase();
                  });
                });
              },
            ),
            const SizedBox(height: 20),
            HomeOptionCard(
              icon: Icons.history,
              title: 'Previous Reports',
              subtitle: 'View your cognitive score history',
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PreviousReportsScreen()))
                    .then((_) {
                  setState(() {});
                });
              },
            ),
            const SizedBox(height: 30),
            buildLineChart("Cognitive Test Progress",
                db.cognitiveTestScreenResults, AppColors.primaryTeal),
            buildLineChart("Speech Test Progress", db.speechTestScreenResults,
                Colors.deepOrangeAccent),
          ],
        ),
      ),
    );
  }
}
