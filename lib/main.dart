import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'welcome_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mento',
      theme: ThemeData(
        primaryColor: Color(0xFFB3E5FC), // Light blue
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFFB3E5FC), // Light blue
          secondary: Color(0xFF0288D1), // Deep blue
        ),
        //BackgroundColor: Color(0xFFF5F5F5), // Light gray
        scaffoldBackgroundColor: Color(0xFFF5F5F5), // Light gray
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Color(0xFF455A64)), // Dark gray
          bodyLarge: TextStyle(fontSize: 18.0, color: Color(0xFF455A64)), // Dark gray
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF4DB6AC)), // Teal
            foregroundColor: MaterialStateProperty.all(Colors.white), // White text
          ),
        ),
      ),
      home: SplashScreen(), // Set SplashScreen as the initial screen
      routes: {
        '/welcome': (context) => WelcomePage(),
      },
    );
  }
}
