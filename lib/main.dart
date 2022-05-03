import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_api_client.dart';
import 'package:weather_app/views/current_weather.dart';
import 'package:weather_app/views/additional_information.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async{
    data=await client.getCurrentWeather("Georgia");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFf9f9f9),
        title: Text('Weather app',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.menu),
        color: Colors.black,),
      ),
      body:FutureBuilder(
        future: getData(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            return Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                currentWeather(Icons.wb_sunny_rounded, '${data!.temp}', '${data!.cityName}'),
                SizedBox(height: 60,),
                Text('Additional information',
                    style: TextStyle(fontSize: 24,color: Color(0xFF212121),
                        fontWeight: FontWeight.bold
                    )
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                additionalInformation('${data!.wind}','${data!.humidity}', '${data!.pressure}','${data!.feels_like}'),
              ],
            );
          }
          else if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
                child:CircularProgressIndicator()
            );
          }
          return Container();
        },
      )
    );
  }
}
