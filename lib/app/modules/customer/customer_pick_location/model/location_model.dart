class LocationModel {
  final double latitude;
  final double longitude;
  final String fullAddress;
  final String streetAddress;
  final String locality;
  final String country;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
    required this.streetAddress,
    required this.locality,
    required this.country,
  });

  // Convert to Map for SharedPreferences
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'fullAddress': fullAddress,
        'streetAddress': streetAddress,
        'locality': locality,
        'country': country,
      };

  // Create from Map from SharedPreferences
  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        latitude: json['latitude'],
        longitude: json['longitude'],
        fullAddress: json['fullAddress'],
        streetAddress: json['streetAddress'],
        locality: json['locality'],
        country: json['country'],
      );
}
