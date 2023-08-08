import 'dart:async';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'Widgets/prayer_card_container_widget.dart';
import 'Widgets/prediction_card.dart';
import 'Widgets/top_weather_widget.dart';
import 'device_config.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

StreamController weatherStreamController = StreamController();

class _MainScreenState extends State<MainScreen> {

  DeviceConfig _device = DeviceConfig();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: mainScreenDecoration,
      child: Column(children: <Widget>[
        TopWeatherWidget(),
        SizedBox(height: _device.height * 0.05),
        PredictionCardContainer(),
        SizedBox(height: _device.height * 0.03),
        PrayerCardContainerWidget(),
      ]),
    );;
  }
}

class PredictionCardContainer extends StatefulWidget {
  @override
  _PredictionCardContainerState createState() =>
      _PredictionCardContainerState();
}

class _PredictionCardContainerState extends State<PredictionCardContainer> {
  late DeviceConfig _device;
  @override
  void initState() {
    _device = DeviceConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: _device.height * 0.25,
        decoration: cardDecoration,
     child: ListView.builder(
         scrollDirection: Axis.horizontal,
        itemCount: 4,
          itemBuilder: (context, index){
            return PredictionCard(
              day: '',
              temprature: 21.7,
              status:'Sunny',
              maxWind: 11.4,
              humidity: 32.0,
            );
          }
      )
    );
  }
}