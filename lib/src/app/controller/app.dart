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



import 'package:flutter/material.dart' show BuildContext, Key, MaterialApp, State, StatefulWidget, Widget;

import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;

import 'package:weather/src/app/view.dart' show SettingsBloc, WeatherHome;

import 'package:weather/src/app/controller.dart' show ThemeBloc, ThemeState;


class App extends StatefulWidget {
  App({Key key}): super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeBloc _themeBloc = ThemeBloc();
  SettingsBloc _settingsBloc = SettingsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _themeBloc,
      child: BlocProvider(
        bloc: _settingsBloc,
        child: BlocBuilder(
          bloc: _themeBloc,
          builder: (_, ThemeState themeState) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: themeState.theme,
              home: WeatherHome(),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();
    _settingsBloc.dispose();
    super.dispose();
  }
}

