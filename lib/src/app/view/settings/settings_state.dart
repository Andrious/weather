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


import 'package:meta/meta.dart' show required;

import 'package:equatable/equatable.dart' show Equatable;

enum TemperatureUnits { fahrenheit, celsius }

class SettingsState extends Equatable {
  final TemperatureUnits temperatureUnits;

  SettingsState({@required this.temperatureUnits})
      : assert(temperatureUnits != null),
        super([temperatureUnits]);
}

