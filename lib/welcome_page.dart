import 'package:flutter/material.dart';
import 'assessment_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Light gray
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Mento',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 48),
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/meditation.png', // Replace with your image path
              height: 450, // Adjust the height as needed
              width: 450,
            ),
            SizedBox(height: 10),
            Text(
              'Your journey to mental wellness starts here. Take a moment to assess your mental health.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssessmentPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4DB6AC), // Teal
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Start Assessment'),
            ),
          ],
        ),
      ),
    );
  }
}
