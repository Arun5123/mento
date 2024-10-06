import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PredictionPage extends StatelessWidget {
  final String result;

  PredictionPage({required this.result});

  @override
  Widget build(BuildContext context) {
    // Convert result to an integer for display
    final int resultValue = (double.parse(result)).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction Result'),
        backgroundColor: Color(0xFFF5F5F5), // Deep blue
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Text(
              'Prediction: $resultValue %' ,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold, // Make text bold
                color: Color(0xFF455A64),
              ),
            ),
            SizedBox(height: 10), // Reduced space between PieChart and button
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.red,
                      value: double.parse(result),
                      title: 'Bad',
                      radius: 100,
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: 100 - double.parse(result),
                      title: 'Good',
                      radius: 100,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10), // Reduced space between PieChart and button
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4DB6AC), // Teal
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}
