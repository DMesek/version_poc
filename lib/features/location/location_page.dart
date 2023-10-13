import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:version_poc/common/error_display.dart';
import 'package:version_poc/version_specific_widget.dart';
import 'package:version_poc/features/location/detailed_location_display.dart';
import 'package:version_poc/features/location/position_manager.dart';
import 'package:version_poc/features/location/simple_location_display.dart';

class LocationPage extends ConsumerWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ref.watch(positionProvider).when(
            data: (positionOrFailure) => positionOrFailure.fold(
              (failure) => Text(failure),
              (position) => VersionSpecificWidget(
                buildForVersion2: () => SimpleLocationDisplay(position),
                buildForVersion3: () => DetailedLocation(position: position),
              ),
            ),
            error: (_, __) => const ErrorDisplay(),
            loading: () => const CircularProgressIndicator(),
          ),
    );
  }
}
