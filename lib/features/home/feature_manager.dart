import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:version_poc/features/posts/posts_page.dart';
import 'package:version_poc/features/location/location_page.dart';
import 'package:version_poc/features/settings/settings_page.dart';
import 'package:version_poc/features/settings/version.dart';
import 'package:version_poc/features/settings/version_notifier.dart';
import 'package:version_poc/features/weather/weather_page.dart';

final featureProvider = Provider<Map<HomeFeatures, Widget>>((ref) {
  final preferredVersion = ref.watch(versionNotifierProvider);
  return switch (preferredVersion) {
    Version.version1 => {
        HomeFeatures.posts: const PostsPage(),
        HomeFeatures.settings: const SettingsPage(),
      },
    _ => {
        HomeFeatures.weather: const WeatherPage(),
        HomeFeatures.location: const LocationPage(),
        HomeFeatures.settings: const SettingsPage(),
      },
  };
});

enum HomeFeatures {
  posts('Posts', Icons.local_post_office),
  weather('Weather', Icons.sunny),
  location('Location', Icons.map),
  settings('Settings', Icons.settings);

  final String name;
  final IconData icon;

  const HomeFeatures(this.name, this.icon);
}
