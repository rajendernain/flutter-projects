import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weater_app/View/Widgets/setting.dart';

import '../device_config.dart';

class TopWeatherWidget extends StatefulWidget {
  @override
  _TopWeatherWidgetState createState() => _TopWeatherWidgetState();
}

class _TopWeatherWidgetState extends State<TopWeatherWidget> {
  late SharedPreferences _pref;
  String city = 'default';
  double temp = 0.0;
  String status = 'default';

  @override
  Widget build(BuildContext context) {
    DeviceConfig _device = DeviceConfig();
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: _device.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/asar.jpg'), fit: BoxFit.cover),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: _device.width * .14,
                ),
                const Text('Kurukshetra',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.deepPurpleAccent,
                    icon: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.black,
                    ),
                    onPressed: () => showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => Setting()),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 0,
            ),
            const Text('40',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: -5,
                  fontSize: 80,
                  fontWeight: FontWeight.w600),
            ),
            const Text('Cloudy',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.2,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}