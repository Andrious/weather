///
/// Copyright (C) 2019 Andrious Solutions
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

import 'package:flutter/material.dart';

import 'package:weather/src/app/view.dart' show WeatherApp;

import 'package:bloc/bloc.dart' show BlocDelegate, BlocSupervisor, Transition;

import 'package:weather/src/app/controller.dart' show App;


void main() => runApp(WeatherApp());

//class SimpleBlocDelegate extends BlocDelegate {
//  @override
//  onTransition(Transition transition) {
//    print(transition);
//  }
//}
//
//void main() {
//  BlocSupervisor().delegate = SimpleBlocDelegate();
//
//  runApp(App());
//}


