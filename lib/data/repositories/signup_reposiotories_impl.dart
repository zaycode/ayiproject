import 'package:ayi/domain/repository/sign_up_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  SignUpRepositoryImpl();

  @override
  Future<Position> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        throw "location_permission_disable";
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw "location_permission_disable";
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        throw "location_permanent_disable";
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      throw "something_wrong";
    }
  }

  Future<Placemark> getAddressFromLatLng(double lat, double lng) async {
    try {
      final response = await placemarkFromCoordinates(lat, lng);
      return response.first;
    } catch (e) {
      throw "something_wrong";
    }
  }
}
