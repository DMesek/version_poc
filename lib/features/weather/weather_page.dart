import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:version_poc/common/api_client.dart';
import 'package:version_poc/common/error_display.dart';
import 'package:version_poc/features/weather/weather.dart';

final weatherProvider = FutureProvider<Weather>(
  (ref) => ref
      .watch(apiClientProvider)
      .getWeatherFor(latitude: 45.8, longitude: 15.9),
);

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherProvider);
    return weatherState.when(
      data: (weather) => WeatherDisplay(weather),
      error: (_, __) => const ErrorDisplay(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final Weather weather;
  const WeatherDisplay(this.weather, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Temperature: ${weather.temperatureInfo.temp}K'),
          const SizedBox(height: 12),
          Text('Pressure: ${weather.temperatureInfo.pressure}Pa'),
          const SizedBox(height: 12),
          Text('Humidity: ${weather.temperatureInfo.humidity}'),
        ],
      ),
    );
  }
}
