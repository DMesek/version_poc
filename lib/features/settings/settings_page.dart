import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:version_poc/features/settings/version_notifier.dart';
import 'package:version_poc/splash_page.dart';
import 'package:version_poc/features/settings/version.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Version?>(versionNotifierProvider, (previous, next) {
      if (previous != next) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          SplashPage.routeName,
          (_) => false,
        );
      }
    });
    return ListView.separated(
      itemBuilder: (_, index) => Version.values
          .map((version) => _VersionSelectionTile(version))
          .elementAt(index),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: Version.values.length,
    );
  }
}

class _VersionSelectionTile extends ConsumerWidget {
  final Version version;
  const _VersionSelectionTile(
    this.version, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(versionNotifierProvider) == version;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog.adaptive(
            title: Text(
              'Are you sure you want to switch the version to ${version.name}?',
            ),
            actions: [
              GestureDetector(
                onTap: () => ref
                    .read(versionNotifierProvider.notifier)
                    .setPreferredVersion(version),
                child: const Text(
                  'Yes',
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Text(
                  'No',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
          left: 30,
          right: 30,
        ),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.check_circle_outline_outlined,
                    color: Colors.green,
                  ),
            const SizedBox(width: 12),
            Text(version.name),
          ],
        ),
      ),
    );
  }
}
