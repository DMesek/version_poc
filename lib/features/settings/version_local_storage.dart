import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:version_poc/features/settings/version.dart';

final versionStorageProvider = Provider<VersionStorage>(
  (_) => SharedPrefsVersionStorage(),
);

abstract interface class VersionStorage {
  Future<Version> get preferredVersion;
  Future storePreferredVersion(Version version);
}

final class SharedPrefsVersionStorage implements VersionStorage {
  @override
  Future<Version> get preferredVersion async {
    final prefs = await SharedPreferences.getInstance();
    final storedIndex = prefs.getInt(_StorageKeys.version.toString());

    if (storedIndex == null) return Version.values.last;
    return Version.values[storedIndex];
  }

  @override
  Future storePreferredVersion(Version version) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_StorageKeys.version.toString(), version.index);
  }
}

enum _StorageKeys { version }
