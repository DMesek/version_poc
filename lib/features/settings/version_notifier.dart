import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:version_poc/features/settings/version.dart';
import 'package:version_poc/features/settings/version_local_storage.dart';

final versionNotifierProvider = StateNotifierProvider<VersionNotifier, Version>(
  (ref) => VersionNotifier(
    ref.watch(
      versionStorageProvider,
    ),
  )..getPreferredVersion(),
);

class VersionNotifier extends StateNotifier<Version> {
  final VersionStorage _versionStorage;
  VersionNotifier(this._versionStorage) : super(Version.values.last);

  void getPreferredVersion() async {
    final version = await _versionStorage.preferredVersion;
    state = version;
  }

  void setPreferredVersion(Version version) async {
    if (state == version) return;

    await _versionStorage.storePreferredVersion(version);
    state = version;
  }
}
