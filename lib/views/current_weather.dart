import 'package:flutter/material.dart';

Widget currentWeather(IconData icon,String temp, String location){
  return Center(
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color:Colors.orange,
          size: 64,
        ),
        SizedBox(height:10),
        Text('$temp',style: TextStyle(
          fontSize: 64
        ),),
        SizedBox(
          height: 10,
        ),
        Text('$location',style: TextStyle(fontSize: 18,color: Color(0xFF5a5a5a)),),



      ],
    )
  );
}