import 'package:flutter/material.dart';
import "dart:convert";
import "package:http/http.dart" as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Weather Forecast')),
        body: FutureBuilder<List<WeatherData>>(
          future: fetchWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("An error occured \n ${snapshot.error}");
            } else if (snapshot.hasData) {
              final weatherData = snapshot.data;
              return WeatherInfo(weatherDataList: weatherData!);
            } else {
              return Text("No data");
            }
          },
        ),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final List<WeatherData> weatherDataList;
  WeatherInfo({required this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: weatherDataList.map((weatherData) {
        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align each column to the left
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 16.0), // Add left padding
              child: Text(
                "Location: ${weatherData.location}",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0), // Add left padding
              child: Text(
                "Temperature: ${weatherData.temperature}°C",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0), // Add left padding
              child: Text(
                "Humidity: ${weatherData.humidity}%",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0), // Add left padding
              child: Text(
                "Wind Speed: ${weatherData.windSpeed} m/s",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(),
          ],
        );
      }).toList(),
    );
  }
}

Future<List<WeatherData>> fetchWeather() async {
  final cities = ['Ankara', 'Istanbul', 'Bursa', 'Izmir', 'Mugla'];

  final apiKey = 'your api';

  List<WeatherData> weatherDataList = [];

  for (final city in cities) {
    final response = await http.get(
      Uri.parse('https://weatherapi-com.p.rapidapi.com/current.json?q=$city'),
      headers: {
        'X-RapidAPI-Key': '$apiKey',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final weatherData = WeatherData.fromJson(jsonDecode(response.body));
      weatherDataList.add(weatherData);
    } else {
      throw Exception('Couldn\'t get data for $city.');
    }
  }

  return weatherDataList;
}

class WeatherData {
  final String location;
  final double temperature;
  final int humidity;
  final double windSpeed;

  WeatherData(
      {required this.location,
      required this.temperature,
      required this.humidity,
      required this.windSpeed});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
        location: json['location']['name'],
        temperature: json['current']['temp_c'],
        humidity: json['current']['humidity'],
        windSpeed: json['current']['wind_mph']);
  }
}
