import 'package:either_dart/either.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final positionProvider = FutureProvider<Either<String, Position>>((ref) async {
  final hasPermission = await _checkLocationPermission();
  return hasPermission.fold(
    (errorMessage) => Left(errorMessage),
    (_) async {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return Right(position);
    },
  );
});

final addressProvider =
    FutureProvider.family<Placemark, Position>((ref, position) async {
  final placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );
  return placemarks[0];
});

Future<Either<String, Object>> _checkLocationPermission() async {
  late LocationPermission permission;

  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return const Left(
        'Location services are disabled. Please enable the services');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return const Left('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return const Left(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return const Right(Object());
}
