// ignore_for_file: deprecated_member_use

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

class LocationService {
  final myBox = Hive.box('mapBox');

  getCurrentLocation() async {
    LocationPermission permission;
    // bool serviceEnabled = await Geolocator.openAppSettings();
    // if (!serviceEnabled) {
    //   Fluttertoast.showToast(
    //     msg: 'Please enable location services',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.grey[600],
    //     textColor: Colors.white,
    //   );
    //   return null;
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return null;
      // if (permission == LocationPermission.denied) {
      //   Fluttertoast.showToast(
      //     msg: 'Location permission denied',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.grey[600],
      //     textColor: Colors.white,
      //   );
      //   return null;
      // }
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    myBox.put("lat", position.latitude);
    myBox.put("lng", position.longitude);
    var lat = myBox.get("lat");
    var lng = myBox.get("lng");
    print("lat====>$lat");
    print("lng====>$lng");
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      var _currentAddress3 =
          "${placemarks.first.street!}, ${placemarks.first.locality!}, ${placemarks.first.country!}";
      myBox.put('address3', _currentAddress3);
      print(placemarks);
    } catch (e) {
      print(e);
    }
    return position;
  }
}
