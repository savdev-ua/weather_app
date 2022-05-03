import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherApiClient{
  Future<Weather>? getCurrentWeather(String? location) async{
    var endpoint=Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=dc775d37cf2ab99357fc98ad9803f4fb&units=metric");

  var response=await http.get(endpoint);
  var body =jsonDecode(response.body);
  print(Weather.fromJson(body).cityName);
  print(Weather.fromJson(body).feels_like);
  print(Weather.fromJson(body).humidity);
  print(Weather.fromJson(body).pressure);
  print(Weather.fromJson(body).temp);
  print(Weather.fromJson(body).wind);
  return Weather.fromJson(body);
  }
}