// ignore_for_file: unused_field

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/components/custom_loading_dialog_widget.dart';
import 'package:dirham_uae/app/data/user_service/user_service.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';

class CustomerPickLocationView extends StatefulWidget {
  final Position currentPosition;
  const CustomerPickLocationView({Key? key, required this.currentPosition})
      : super(key: key);
  @override
  State<CustomerPickLocationView> createState() =>
      _CustomerPickLocationViewState();
}

class _CustomerPickLocationViewState extends State<CustomerPickLocationView> {
  final Completer<GoogleMapController> _controller = Completer();

  final TextEditingController _searchController = TextEditingController();
  UserService userService = UserService();

  GoogleMapController? googleMapController;
  final Set<Marker> _markers = {};
  String? _currentAddress;
  String? _currentAddress2;
  String? _currentAddress3;
  final myBox = Hive.box('mapBox');
  CameraPosition? _cameraPosition;

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: const MarkerId('current_location'),
      position: LatLng(
        widget.currentPosition.latitude,
        widget.currentPosition.longitude,
      ),
    ));
    _getCurrentAddress();
    print("Gained lat========>>>>>${widget.currentPosition.latitude}");
    print("Gained lng========>>>>>${widget.currentPosition.longitude}");
  }

  Future<void> _getCurrentAddress() async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      widget.currentPosition.latitude,
      widget.currentPosition.longitude,
    );
    setState(() {
      _currentAddress =
          "${placemarks.first.locality!.toUpperCase()}, ${placemarks.first.country!.toUpperCase()}";
      _currentAddress2 =
          "${placemarks.first.street!}, ${placemarks.first.locality!}";
      _currentAddress3 =
          "${placemarks.first.street!}, ${placemarks.first.locality!}, ${placemarks.first.country!}";
      myBox.put('address3', _currentAddress3);
    });
  }

  void _onCameraMove(CameraPosition position) {
    _cameraPosition = position;
    // Update the marker position
    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId('current_location'),
        position: _cameraPosition!.target,
      ));
    });
  }

  void _updatePosition() async {
    // Update the marker position
    setState(() {
      _markers.clear();
      if (_cameraPosition != null) {
        _markers.add(Marker(
          markerId: const MarkerId('current_location'),
          position: _cameraPosition!.target,
        ));
      }
    });
    // Update the current address variables
    if (_cameraPosition != null) {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        _cameraPosition!.target.latitude,
        _cameraPosition!.target.longitude,
      );
      setState(() {
        _currentAddress =
            "${placemarks.first.locality!.toUpperCase()}, ${placemarks.first.country!.toUpperCase()}";
        _currentAddress2 =
            "${placemarks.first.street!}, ${placemarks.first.locality!}";
        _currentAddress3 =
            "${placemarks.first.street!}, ${placemarks.first.locality!}, ${placemarks.first.country!}, ${placemarks.first.name!}";
        myBox.put('address3', _currentAddress3);
      });
      // Update the stored latitude and longitude values
      myBox.put("lat", _cameraPosition!.target.latitude);
      myBox.put("lng", _cameraPosition!.target.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.currentPosition.latitude,
              widget.currentPosition.longitude,
            ),
            zoom: 12,
          ),
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
            _controller.complete(controller);
          },
          scrollGesturesEnabled: !Get.isDialogOpen!,
          onCameraMove: _onCameraMove,
          markers: _markers,
          onCameraIdle: _updatePosition,
        ),

        //*************************** */

        SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(Images.mapImg),
            //     fit: BoxFit.cover,
            //   ),
            //),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //*************************************** Search Location Section *************************** */
                  TextFormField(
                    scrollPadding: EdgeInsets.zero,
                    cursorColor: LightThemeColors.primaryColor,
                    decoration: InputDecoration(
                      filled: true,
                      focusColor: LightThemeColors.secounderyBackgroundColor,
                      fillColor: LightThemeColors.secounderyBackgroundColor,
                      hintText: "Search Location",
                      prefixIconColor: Colors.black,
                      prefixIcon: ImageIcon(AssetImage(Img.locationIcon)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: LightThemeColors.secounderyBackgroundColor,
                            width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: LightThemeColors.secounderyBackgroundColor,
                            width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: LightThemeColors.secounderyBackgroundColor,
                            width: 2),
                      ),
                    ),
                  ),
                  Spacer(),

                  //*************************************** Button Section *************************** */
                  CustomButton(
                    widget: Text("Pick Location"),
                    bgColor: LightThemeColors.primaryColor,
                    ontap: () async {
                      //********************* Search Location Section ****************** */
                      Get.back();
                      showDialog(
                          context: context,
                          builder: (c) {
                            return BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: const CustomLoadingWidget(
                                message: "Set Location",
                              ),
                            );
                          });

                      var lat = myBox.get("lat");
                      var lng = myBox.get("lng");
                      print("Changed lat====>$lat");
                      print("Changed lng====>$lng");
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
