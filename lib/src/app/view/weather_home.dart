///
/// Copyright (C) 2019 Felix Angelov of Skokie, Illinois
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
///          Created  13 Feb 2019
///
///

import 'dart:async' show Completer;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;

import 'package:weather/src/app/controller.dart';

import 'package:weather/src/app/view.dart';

class WeatherHome extends StatefulWidget {
  WeatherHome({Key key}) : super(key: key);

  @override
  State<WeatherHome> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherHome> {
  WeatherBloc _weatherBloc;
  Completer<void> _refreshCompleter;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _weatherBloc = WeatherBloc();
  }

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SettingsDrawer(
          con: Switcher(
              temperatureUnits: settingsBloc.currentState.temperatureUnits,
              onChanged: (bool set) {
                settingsBloc.dispatch(TemperatureUnitsToggled());
                Navigator.pop(context);
              })),
      appBar: AppBar(
        title: Text('Flutter Weather'),
        actions: <Widget>[
          IconButton(
              icon: new Icon(Icons.settings),
              onPressed: () => _scaffoldKey.currentState.openEndDrawer()),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                _weatherBloc.dispatch(FetchWeather(city: city));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _weatherBloc,
          builder: (_, WeatherState state) {
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherEmpty) {
              return Center(child: Text('Please Select a Location'));
            }
            if (state is WeatherLoaded) {
              final weather = state.weather;
              final themeBloc = BlocProvider.of<ThemeBloc>(context);
              themeBloc.dispatch(WeatherChanged(condition: weather.condition));

              _refreshCompleter?.complete();
              _refreshCompleter = Completer();

              return BlocBuilder(
                bloc: themeBloc,
                builder: (_, ThemeState themeState) {
                  return GradientContainer(
                    color: themeState.color,
                    child: RefreshIndicator(
                      onRefresh: () {
                        _weatherBloc.dispatch(
                          RefreshWeather(city: state.weather.location),
                        );
                        return _refreshCompleter.future;
                      },
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 100.0),
                            child: Center(
                              child: Location(location: weather.location),
                            ),
                          ),
                          Center(
                            child: LastUpdated(dateTime: weather.lastUpdated),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.0),
                            child: Center(
                              child: CombinedWeatherTemperature(
                                weather: weather,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is WeatherError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    super.dispose();
  }
}

class AppMenu {
  static State _state;

  static PopupMenuButton<String> show(State state) {
    _state = state;
    return PopupMenuButton<String>(
      onSelected: _showMenuSelection,
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
            PopupMenuItem<String>(value: 'Settings', child: Text('Settings')),
            const PopupMenuItem<String>(value: 'About', child: Text('About')),
          ],
    );
  }

  static _showMenuSelection(String value) async {
    switch (value) {
      case 'Settings':
        TempUnits.show(
          context: _state.context,
        );
        break;
      case 'About':
        showAboutDialog(
            context: _state.context,
            applicationName: "Flutter Weather",
            children: [Text('A Flutter Weather App')]);
        break;
      default:
    }
  }
}

class TempUnits {
  static Future<void> show({
    @required BuildContext context,
  }) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    bool unitSet =
        settingsBloc.currentState.temperatureUnits == TemperatureUnits.celsius;
    String unitLabel = unitSet ? 'Celsius' : 'Fahrenheit';
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) =>
            SimpleDialog(title: Text(unitLabel), children: <Widget>[
              Container(
                  padding: EdgeInsets.all(9.0),
                  child: Center(
                    child: Column(children: [
                      Switch(
                          value: unitSet,
                          onChanged: (bool set) {
                            settingsBloc.dispatch(TemperatureUnitsToggled());
                            Navigator.pop(context);
                          })
                    ]),
                  )),
            ]));
  }
}
