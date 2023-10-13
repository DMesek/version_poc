import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:version_poc/features/settings/version.dart';
import 'package:version_poc/features/settings/version_notifier.dart';

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
