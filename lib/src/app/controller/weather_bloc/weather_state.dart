

import 'package:meta/meta.dart' show required;

import 'package:equatable/equatable.dart' show Equatable;

import 'package:weather/src/app/model.dart' show Weather;

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({@required this.weather})
      : assert(weather != null),
        super([weather]);
}

class WeatherError extends WeatherState {}


