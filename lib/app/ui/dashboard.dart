import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: Text('COVID-19 Tracker'),
        
      ) ,
      body: ListView(
        children: <Widget>[

        ],
      ),
    );
  }
}