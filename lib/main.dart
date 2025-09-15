import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Info App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _controller = TextEditingController();

  // placeholders for weather data
  String city = "";
  String temperature = "";
  String condition = "";

  void _simulateWeather() {
    final random = Random();

    setState(() {
      city = _controller.text;
      temperature = "${15 + random.nextInt(16)}°C"; // random 15–30
      final conditions = ["Sunny", "Cloudy", "Rainy"];
      condition = conditions[random.nextInt(conditions.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather Info")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter City",
              ),
            ),
            SizedBox(height: 10),

            // Fetch button
            ElevatedButton(
              onPressed: _simulateWeather,
              child: Text("Fetch Weather"),
            ),
            SizedBox(height: 30),

            // Display weather info only if city is entered
            if (city.isNotEmpty)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weather Report",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "City: $city",
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                      Text(
                        "Temperature: $temperature",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Condition: $condition",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
