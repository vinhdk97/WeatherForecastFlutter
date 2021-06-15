import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
  title: "weather app",
  home: Home(),
));


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
//create variable
var temp;
var description;
var currently;
var hudimity;
var windSpeed;
var city;

Future getWeater () async{
  http.Response response = await http.get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=Thanh%20pho%20Ho%20Chi%20Minh&appid=dc4af47f83e4e3e685cea309d2de2e82"));
  var results= jsonDecode(response.body);
  setState(() {
      this.temp = results['main']['temp'];
      this.temp = (temp/10).round() ;
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.hudimity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.city  = results["name"];

    });
}

  @override
  void initState(){
    super.initState();
    this.getWeater();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Padding(padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "currently in "+ city !=null ? city.toString() : "null",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ),
              Text(
               temp != null ? temp.toString()+ "\u00B0C" : "Loading",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0),
              child: Text(
                description != null ? description.toString() : "Loading",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              )

            ],),
          ),
          Expanded(child: Padding(padding: EdgeInsets.all(20.0),child: RefreshIndicator(
            onRefresh: getWeater,
            child: ListView(
              children: [
              ListTile(
                leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                title: Text("Temperature"),
                trailing: Text(temp != null ? temp.toString()+ "\u00B0C" : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloud),
                title: Text("Weather"),
                trailing: Text(description != null ? description.toString(): "Loading",),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sun),
                title: Text("Humidity"),
                trailing: Text(hudimity != null ? hudimity.toString()+" %": "Loading",),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text("Wind Speed"),
                trailing: Text(windSpeed != null ? windSpeed.toString()+ " m/s" : "Loading",),
              )
            ],),
          ),))
        ],
      ),
    );
  }
}