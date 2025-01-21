import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullMapView extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String location;

  const FullMapView({
    required this.latitude,
    required this.longitude,
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15, // Higher zoom for more detail
        ),
        markers: {
          Marker(
            markerId: MarkerId("destination"),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: location),
          )
        },
      ),
    );
  }
}
