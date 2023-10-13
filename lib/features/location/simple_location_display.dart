import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SimpleLocationDisplay extends StatelessWidget {
  final Position position;
  const SimpleLocationDisplay(
    this.position, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('LAT: ${position.latitude} LONG: ${position.longitude}');
  }
}
