import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Weather {
  @JsonKey(name: 'main')
  final TemperatureInfo temperatureInfo;

  Weather(this.temperatureInfo);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TemperatureInfo {
  final double temp;
  final int pressure;
  final int humidity;

  TemperatureInfo(
    this.temp,
    this.pressure,
    this.humidity,
  );

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) =>
      _$TemperatureInfoFromJson(json);
}
