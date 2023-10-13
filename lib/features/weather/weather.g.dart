// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      TemperatureInfo.fromJson(json['main'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'main': instance.temperatureInfo,
    };

TemperatureInfo _$TemperatureInfoFromJson(Map<String, dynamic> json) =>
    TemperatureInfo(
      (json['temp'] as num).toDouble(),
      json['pressure'] as int,
      json['humidity'] as int,
    );

Map<String, dynamic> _$TemperatureInfoToJson(TemperatureInfo instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };
