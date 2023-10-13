# Version POC

A simple POC app that showcases the version selection feature.

## Get the app 🚀

You can download the POC App by scanning the QR code below:

![Screenshot](install_qr.png)

NOTE: you'll have to trust the apps downloaded from Chrome and 

## Versions

### Version 1.0.0

Initial version of the app with some dummy features

* Simple API call to https://jsonplaceholder.typicode.com/posts and displaying the posts in a list

* Settings page where the user can select the desired version

### Version 2.0.0

This version showcases the scenario when the baseUrl of our API would change (Posts -> Weather). It also shows the addition of another feature. 

* Instead of the Posts feature, first tab contains weather data for a specific dummy location.

* Added location display (latitude and longitude) feature

### Version 2.1.0

This version showcases the scenario when only a part of a feature has been modified in the latest version.

* Added address detection based on provided longitude and latitude

## Code that does most of the magic 🪄

### Version enum

Configuration file for each available version. Once another version is added to this file, the developer will be prompted to exhaustively handle each version where this enum is referenced. It is visible that the baseUrl has been changed after version1.

```dart
enum Version {
  version1('1.0.0', 'https://jsonplaceholder.typicode.com'),
  version2('2.0.0', 'https://api.openweathermap.org/data/2.5'),
  version3('2.1.0', 'https://api.openweathermap.org/data/2.5');

  final String name;
  final String baseUrl;
  const Version(this.name, this.baseUrl);
}
```

### Version specific widget

Wrapper for every widget that could change after switching to another version. This was used in order to reuse the location feature from version 2.0.0 and add the address part in version 2.1.0

```dart
class VersionSpecificWidget extends ConsumerWidget {
  final Widget Function()? buildForVersion1;
  final Widget Function()? buildForVersion2;
  final Widget Function()? buildForVersion3;
  const VersionSpecificWidget({
    this.buildForVersion1,
    this.buildForVersion2,
    this.buildForVersion3,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVersion = ref.watch(versionNotifierProvider);
    return switch (selectedVersion) {
      Version.version1 => buildForVersion1?.call() ?? const SizedBox(),
      Version.version2 => buildForVersion2?.call() ?? const SizedBox(),
      Version.version3 => buildForVersion3?.call() ?? const SizedBox(),
    };
  }
}
```

### API Client Provider

Provider that watches the selected version and provides the appropriate baseUrl based on the version.

```dart
final apiClientProvider = Provider<ApiClient>(
  (ref) {
    final selectedVersion = ref.watch(versionNotifierProvider);
    return ApiClient(
      ref.watch(
        dioProvider(selectedVersion.baseUrl),
      ),
    );
  },
);
```

### Feature Manager

Provider that is responsible for showing the tabs on the home screen. As it is visible from the code below, version1 (1.0.0) includes the posts feature, where all the other available versions include the weather and location feature instead of the posts feature.

```dart
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
```

## Note

This app was not built using clean architecture, as it was not the focus of this POC. The primary purpose of this repo is to showcase the version switching logic and potential scenarios. 


