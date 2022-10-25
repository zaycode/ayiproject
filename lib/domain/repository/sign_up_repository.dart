import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class SignUpRepository {
  Future<Position> getCurrentLocation();
  Future<Placemark> getAddressFromLatLng(double lat, double lng);
}
