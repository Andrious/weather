import 'package:meta/meta.dart' show required;

import 'package:bloc/bloc.dart' show Bloc;

import 'package:weather/src/app/model.dart' show Weather;

import 'package:weather/src/app/controller.dart'
    show
        FetchWeather,
        RefreshWeather,
        WeatherEmpty,
        WeatherError,
        WeatherEvent,
        WeatherLoaded,
        WeatherLoading,
        WeatherRepository,
        WeatherState;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepository weatherRepository = WeatherRepository();

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherState currentState,
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }

    if (event is RefreshWeather) {
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield currentState;
      }
    }
  }
}
