///
/// Copyright (C) 2018 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  10 Sep 2018
///

import 'package:flutter/material.dart';

import 'package:weather/src/app/view.dart';

class SettingsDrawer extends StatefulWidget {
  SettingsDrawer({this.con, Key key}) : super(key: key);
  final Switcher con;
  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  @override
  Widget build(BuildContext context) {
    bool unitSet = widget.con.temperatureUnits == TemperatureUnits.celsius;
    String unitLabel = unitSet ? 'Celsius' : 'Fahrenheit';
    String subTitle =
        'Use ${unitSet ? 'metric' : 'imperial'} measurements for temperatur untis';
    return Drawer(
      child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Settings',
                style: const TextStyle(color: Colors.white),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: const Text('Temperature Untis'),
              subtitle: Text(subTitle),
              trailing: Switch(
                value: unitSet,
                onChanged: widget.con.onChanged,
              ),
            ),
          ]),
    );
  }

  static void onTap() {
    var test = true;
  }
}

class Switcher {
  Switcher({this.temperatureUnits, this.onChanged});
  TemperatureUnits temperatureUnits = TemperatureUnits.celsius;
  ValueChanged<bool> onChanged = (bool value) {};
}
