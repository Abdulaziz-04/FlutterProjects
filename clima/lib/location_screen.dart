import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String inputCity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 50.0, horizontal: 40.0),
                child: TextField(
                  onChanged: (value) {
                    inputCity = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter City..',
                      icon: Icon(Icons.location_city)),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0)),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.blue[800].withOpacity(0.4)),
                ),
                onPressed: () {
                  //pops the value to previous screen
                  Navigator.pop(context, inputCity);
                },
                child: Text(
                  'Get Weather',
                  style: TextStyle(
                      fontFamily: 'Spartan MB',
                      fontSize: 30.0,
                      color: Colors.white70),
                ),
              ),
            ],
          ),
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/city.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
