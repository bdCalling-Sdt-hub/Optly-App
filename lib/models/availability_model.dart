
import 'dart:convert';

class AvailabilityModel {
  final bool? success;
  final Data? data;
  final dynamic message;

  AvailabilityModel({
    this.success,
    this.data,
    this.message,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) => AvailabilityModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final dynamic data;
  final Config? config;
  final bool? available;
  final dynamic metainfo;
  final List<dynamic>? customers;

  Data({
    this.data,
    this.config,
    this.available,
    this.metainfo,
    this.customers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"],
    config: json["config"] == null ? null : Config.fromJson(json["config"]),
    available: json["available"],
    metainfo: json["metainfo"],
    customers: json["customers"] == null ? [] : List<dynamic>.from(json["customers"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "config": config?.toJson(),
    "available": available,
    "metainfo": metainfo,
    "customers": customers == null ? [] : List<dynamic>.from(customers!.map((x) => x)),
  };
}

class Config {
  final   List<Shift>? schichtnames;
  final int? showschichtnames;
  final dynamic availabilitytemplate;

  Config({
    this.schichtnames,
    this.showschichtnames,
    this.availabilitytemplate,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    schichtnames:(jsonDecode(json['schichtnames']) as List)
      .map((e) => Shift.fromJson(e))
      .toList(),
    showschichtnames: json["showschichtnames"],
    availabilitytemplate: json["availabilitytemplate"],
  );

  Map<String, dynamic> toJson() => {
    "schichtnames": schichtnames,
    "showschichtnames": showschichtnames,
    "availabilitytemplate": availabilitytemplate,
  };
}

class Shift {
  String name;
  String startTime;
  String endTime;

  Shift({required this.name, required this.startTime, required this.endTime});

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      name: json['name'],
      startTime: json['starttime'],
      endTime: json['endtime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'starttime': startTime,
      'endtime': endTime,
    };
  }
}
