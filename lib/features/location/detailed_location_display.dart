import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:version_poc/common/error_display.dart';
import 'package:version_poc/features/location/position_manager.dart';
import 'package:version_poc/features/location/simple_location_display.dart';

class DetailedLocation extends ConsumerWidget {
  final Position position;
  const DetailedLocation({
    required this.position,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressState = ref.watch(addressProvider(position));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SimpleLocationDisplay(position),
          const SizedBox(height: 12),
          addressState.when(
            data: (place) => Text(
              '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}',
              textAlign: TextAlign.center,
            ),
            error: (_, __) => const ErrorDisplay(),
            loading: () => const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
