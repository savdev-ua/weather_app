import 'package:flutter/material.dart';
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
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
        currentWeather(Icons.wb_sunny_rounded, '24', 'Georgia'),
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
          additionalInformation('24','2', '1014','24.6'),
        ],
      ),
    );
  }
}
