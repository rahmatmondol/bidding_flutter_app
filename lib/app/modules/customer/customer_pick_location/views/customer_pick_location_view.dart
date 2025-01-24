// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../../../../config/theme/light_theme_colors.dart';
// import '../../../../components/custom_button.dart';
// import '../controllers/customer_pick_location_controller.dart';
//
// class CustomerPickLocationView extends GetView<CustomerPickLocationController> {
//   CustomerPickLocationView({Key? key}) : super(key: key);
//
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Obx(() {
//             final currentLocation = controller.getCurrentActiveAddress();
//             return GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                   currentLocation?.latitude ?? 25.2048,
//                   currentLocation?.longitude ?? 55.2708,
//                 ),
//                 zoom: 14.0,
//               ),
//               onMapCreated: (GoogleMapController controller) {
//                 // Use the setMapController method here
//                 this.controller.setMapController(controller);
//               },
//               markers: {
//                 Marker(
//                   markerId: const MarkerId('selected_location'),
//                   position: LatLng(
//                     currentLocation?.latitude ?? 25.2048,
//                     currentLocation?.longitude ?? 55.2708,
//                   ),
//                 )
//               },
//               onCameraMove: (position) {
//                 controller.pickLocationFromMap(position.target);
//               },
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//             );
//           }),
//
//           // Search Box with Results
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: TextField(
//                       controller: searchController,
//                       style: TextStyle(
//                         // Add explicit text style
//                         color: Colors.black,
//                         fontSize: 16,
//                         decoration: TextDecoration.none,
//                       ),
//                       decoration: InputDecoration(
//                         hintText: 'Search location',
//                         hintStyle: TextStyle(
//                           // Add hint text style
//                           color: Colors.grey,
//                           fontSize: 16,
//                         ),
//                         prefixIcon: Icon(Icons.search, color: Colors.grey),
//                         border: InputBorder.none,
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         fillColor: Colors.white,
//                         // Ensure the fill color is white
//                         filled: true,
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide.none,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       onChanged: (value) {
//                         print("Search text: $value");
//                         controller.searchLocation(value);
//                       },
//                     ),
//                   ),
//
//                   // Search Results
//                   Obx(() {
//                     if (controller.searchResults.isNotEmpty) {
//                       return Container(
//                         margin: EdgeInsets.only(top: 8),
//                         constraints: BoxConstraints(maxHeight: 200),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: controller.searchResults.length,
//                           itemBuilder: (context, index) {
//                             final location = controller.searchResults[index];
//                             return ListTile(
//                               title: Text(location.streetAddress),
//                               subtitle: Text(location.locality),
//                               onTap: () async {
//                                 // Update location
//                                 await controller.updateLocation(
//                                   controller.selectedAddressIndex.value,
//                                   location,
//                                 );
//
//                                 // Move map to selected location using controller's method
//                                 controller.moveMapToLocation(LatLng(
//                                     location.latitude, location.longitude));
//
//                                 // Clear search
//                                 searchController.clear();
//                                 controller.searchResults.clear();
//                               },
//                             );
//                           },
//                         ),
//                       );
//                     }
//                     return SizedBox.shrink();
//                   }),
//                 ],
//               ),
//             ),
//           ),
//
//           // Bottom Buttons
//           Positioned(
//             bottom: 16,
//             left: 16,
//             right: 16,
//             child: Column(
//               children: [
//                 CustomButton(
//                   widget: Text("Confirm Location"),
//                   bgColor: LightThemeColors.primaryColor,
//                   ontap: () {
//                     final selectedLocation =
//                         controller.getCurrentActiveAddress();
//                     if (selectedLocation != null) {
//                       print("Selected location to return:");
//                       print("Latitude: ${selectedLocation.latitude}");
//                       print("Longitude: ${selectedLocation.longitude}");
//                       print("Address: ${selectedLocation.fullAddress}");
//
//                       // Return to previous page with location data
//                       Get.back(result: selectedLocation);
//                     } else {
//                       Get.snackbar('Error', 'Please select a location first');
//                     }
//                   },
//                 ),
//                 // CustomButton(
//                 //   widget: Text("Confirm Location"),
//                 //   bgColor: LightThemeColors.primaryColor,
//                 //   ontap: () {
//                 //     if (controller.getCurrentActiveAddress() != null) {
//                 //       Get.toNamed(Routes.CUSTOMER_NAV_BAR);
//                 //     } else {
//                 //       Get.snackbar('Error', 'Please select a location first');
//                 //     }
//                 //   },
//                 // ),
//                 SizedBox(height: 8),
//                 CustomButton(
//                   widget: Text("Use Current Location"),
//                   bgColor: LightThemeColors.secounderyButtonColor,
//                   ontap: () async {
//                     final success = await controller.getCurrentLocation();
//                     if (success) {
//                       // Move map to current location if successful
//                       final currentLocation =
//                           controller.getCurrentActiveAddress();
//                       if (currentLocation != null) {
//                         controller.moveMapToLocation(LatLng(
//                             currentLocation.latitude,
//                             currentLocation.longitude));
//                       }
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//           // Loading Indicator
//           Obx(() {
//             if (controller.isLoading.value) {
//               return Container(
//                 color: Colors.black.withOpacity(0.3),
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             }
//             return SizedBox.shrink();
//           }),
//         ],
//       ),
//     );
//   }
// }
