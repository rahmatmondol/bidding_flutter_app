// To parse this JSON data, do
//
//     final getZoneId = getZoneIdFromJson(jsonString);

import 'dart:convert';

GetZoneId getZoneIdFromJson(String str) => GetZoneId.fromJson(json.decode(str));

String getZoneIdToJson(GetZoneId data) => json.encode(data.toJson());

class GetZoneId {
  bool? success;
  int? status;
  String? message;
  Data? data;

  GetZoneId({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory GetZoneId.fromJson(Map<String, dynamic> json) => GetZoneId(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<Zone>? zones;

  Data({
    this.zones,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        zones: json["zones"] == null
            ? []
            : List<Zone>.from(json["zones"]!.map((x) => Zone.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "zones": zones == null
            ? []
            : List<dynamic>.from(zones!.map((x) => x.toJson())),
      };
}

class Zone {
  int? id;
  String? name;

  Zone({
    this.id,
    this.name,
  });

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
