import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_api_client.dart';
import 'package:weather_app/views/current_weather.dart';
import 'package:weather_app/views/additional_information.dart';
String city="Lviv";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async{
    data=await client.getCurrentWeather(city);
  }

  void secondCaller(){
    setState(() => getData());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:false,
      backgroundColor: Color(0xFFf9f9f9),
      
      body:
          SafeArea(
            child: FutureBuilder(
              future: getData(),
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.done){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SearchBar(),
                      SizedBox(height: 20,),
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

                      SizedBox(height: 20,),
                      CupertinoButton(
                    child: Text('Find',style: TextStyle(fontSize: 30),),
                          color: CupertinoColors.black,
                          onPressed: (){
                          setState(() {
                          getData();
                          });}
                          ),
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
            ),
          ),
      
      
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  _HomePageState home=_HomePageState();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child:
      CupertinoTextField(
        placeholder: "City name",
        autocorrect: true,
        controller: controller,
        prefix: const Padding(
            padding:  EdgeInsets.only(left: 5),
            child: Icon(CupertinoIcons.search)),

        style: TextStyle(fontSize: 25,),
        onChanged: (String value) {
          print('The text has changed to: $value');
        },
        onSubmitted: (String value) {
          setState(() {
            city=value;
            home.secondCaller();
          });



        },
      ),

    );
  }
}
