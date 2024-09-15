import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'prediction_page.dart';

class AssessmentPage extends StatefulWidget {
  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  String _selectedCountry = 'United States';
  int _birthYear = 1990;
  double _schizophrenia = 0.0;
  double _bipolar = 0.0;
  double _eatingDisorder = 0.0;
  double _anxiety = 0.0;

  String _result = '';
  String _errorMessage = ''; // To display error messages

  Future<void> _getPrediction() async {
    final url = Uri.parse('http://192.0.0.2:5000/predict');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'country': _selectedCountry,
          'year_of_birth': _birthYear,
          'schizophrenia': _schizophrenia,
          'bipolar_disorder': _bipolar,
          'eating_disorder': _eatingDisorder,
          'anxiety': _anxiety,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _result = responseData['prediction'].toString();
          _errorMessage = ''; // Clear any previous error messages
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PredictionPage(result: _result),
          ),
        );
      } else {
        setState(() {
          _result = '';
          _errorMessage = 'Error: Could not get prediction. Status code: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        _result = '';
        _errorMessage = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessment'),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 60),
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                decoration: InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                items: ['United States', 'Canada', 'United Kingdom', 'Australia', 'India', 'Other']
                    .map((country) => DropdownMenuItem(value: country, child: Text(country)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCountry = value!),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Year of Birth',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() => _birthYear = int.parse(value)),
              ),
              SizedBox(height: 16),
              _buildSlider('Schizophrenia', _schizophrenia, (value) => setState(() => _schizophrenia = value)),
              SizedBox(height: 16),
              _buildSlider('Bipolar Disorder', _bipolar, (value) => setState(() => _bipolar = value)),
              SizedBox(height: 16),
              _buildSlider('Eating Disorder', _eatingDisorder, (value) => setState(() => _eatingDisorder = value)),
              SizedBox(height: 16),
              _buildSlider('Anxiety', _anxiety, (value) => setState(() => _anxiety = value)),
              SizedBox(height: 30),
              // Center the button
              Center(
                child: ElevatedButton(
                  onPressed: _getPrediction,
                  child: Text('Get Prediction'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[700],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('$label: ${value.round()}%', style: TextStyle(fontSize: 16)),
        Slider(
          value: value,
          min: 0,
          max: 100,
          divisions: 100,
          label: value.round().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
