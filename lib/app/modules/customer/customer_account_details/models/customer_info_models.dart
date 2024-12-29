// To parse this JSON data, do
//
//     final getCustomerInfoModel = getCustomerInfoModelFromJson(jsonString);

import 'dart:convert';

GetCustomerInfoModel getCustomerInfoModelFromJson(String str) => GetCustomerInfoModel.fromJson(json.decode(str));

String getCustomerInfoModelToJson(GetCustomerInfoModel data) => json.encode(data.toJson());

class GetCustomerInfoModel {
    bool? success;
    int? status;
    String? message;
    Data? data;

    GetCustomerInfoModel({
        this.success,
        this.status,
        this.message,
        this.data,
    });

    factory GetCustomerInfoModel.fromJson(Map<String, dynamic> json) => GetCustomerInfoModel(
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
    Info? info;

    Data({
        this.info,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
    );

    Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
    };
}

class Info {
    int? id;
    String? name;
    String? email;
    String? phone;
    int? emailVerify;
    String? image;
    String? status;

    Info({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.emailVerify,
        this.image,
        this.status,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        emailVerify: json["email_verify"],
        image: json["image"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "email_verify": emailVerify,
        "image": image,
        "status": status,
    };
}
