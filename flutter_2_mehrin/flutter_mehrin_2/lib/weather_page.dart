import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:supabase_flutter/supabase_flutter.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() {
    return _WeatherPageState();
  }
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  final _supabase = Supabase.instance.client;
  final String _apiKey = '5370c22d8cd9c0459f283723ce915421';

  String _cityName = '';
  String _temp = '';
  String _description = '';
  String _humidity = '';
  String _wind = '';
  String _feelsLike = '';
  bool _isLoading = false;
  bool _hasResult = false;
  String _error = '';

  void _getWeather() async {
    String city = _cityController.text.trim();
    if (city.isEmpty) return;
    setState(() {
      _isLoading = true;
      _hasResult = false;
      _error = '';
    });
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric',
      ),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _cityName = data['name'];
        _temp = data['main']['temp'].round().toString();
        _description = data['weather'][0]['description'];
        _humidity = data['main']['humidity'].toString();
        _wind = data['wind']['speed'].toString();
        _feelsLike = data['main']['feels_like'].round().toString();
        _isLoading = false;
        _hasResult = true;
      });
    } else {
      setState(() {
        _error = 'City not found! Please try again.';
        _isLoading = false;
      });
    }
  } //getWeather

  void _saveCity() async {
    final userId = _supabase.auth.currentUser!.id;
    try {
      await _supabase.from('favorite_cities').insert({
        'user_id': userId,
        'city_name': _cityName,
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$_cityName saved!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  } //saveCity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
        title: Text("Check Weather"),
        backgroundColor: Colors.pink.shade200,
        foregroundColor: Colors.pink.shade900,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // SEARCH BOX
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,

                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.pink.shade200,
                  border: Border.all(color: Colors.pink.shade900, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Text(
                      "Enter City Name",
                      style: TextStyle(
                        color: Colors.pink.shade900,
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 15),

                    TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        hintText: ' city name .....',
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.pink.shade700,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: _getWeather,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade400,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70),
                          side: BorderSide(
                            color: Colors.pink.shade900,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        "Search",
                        style: TextStyle(
                          color: Colors.pink.shade100,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (_isLoading)
              Padding(
                padding: const EdgeInsets.all(10),
                child: CircularProgressIndicator(color: Colors.pink.shade400),
              ),
            // ERROR
            if (_error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade200,
                    border: Border.all(color: Colors.pink.shade400, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(
                    child: Text(
                      _error,
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

            if (_hasResult)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade300,
                    border: Border.all(color: Colors.pink.shade900, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _cityName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        _description.toUpperCase(),
                        style: TextStyle(
                          color: Colors.pink.shade100,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        '$_temp°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (_hasResult)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade200,
                    border: Border.all(color: Colors.pink.shade900, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Weather Details",
                        style: TextStyle(
                          color: Colors.pink.shade900,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.water_drop,
                                color: Colors.pink.shade700,
                                size: 30,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '$_humidity%',
                                style: TextStyle(
                                  color: Colors.pink.shade900,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Humidity',
                                style: TextStyle(color: Colors.pink.shade700),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              Icon(
                                Icons.air,
                                color: Colors.pink.shade700,
                                size: 30,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '$_wind m/s',
                                style: TextStyle(
                                  color: Colors.pink.shade900,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Wind',
                                style: TextStyle(color: Colors.pink.shade700),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              Icon(
                                Icons.thermostat,
                                color: Colors.pink.shade700,
                                size: 30,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '$_feelsLike°C',
                                style: TextStyle(
                                  color: Colors.pink.shade900,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Feels Like',
                                style: TextStyle(color: Colors.pink.shade700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            if (_hasResult)
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: _saveCity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70),
                      side: BorderSide(color: Colors.pink.shade900, width: 4),
                    ),
                  ),
                  child: Text(
                    " Save City",
                    style: TextStyle(
                      color: Colors.pink.shade100,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
