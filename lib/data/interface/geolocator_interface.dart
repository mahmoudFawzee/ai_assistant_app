import 'package:geolocator/geolocator.dart';

abstract class GeolocatorInterface {
  Future<Position> determinePosition();
}
