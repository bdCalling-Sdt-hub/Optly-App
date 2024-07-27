class CheckInModel {
  final bool? success;
  final Data? data;
  final dynamic message;

  CheckInModel({
    this.success,
    this.data,
    this.message,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) => CheckInModel(
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
  final Info? info;
  final bool? hasCurrent;
  final dynamic config;
  final dynamic schicht;

  Data({
    this.info,
    this.hasCurrent,
    this.config,
    this.schicht,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    info: json["info"] == null ? null : Info.fromJson(json["info"]),
    hasCurrent: json["hasCurrent"],
    config: json["config"],
    schicht: json["schicht"],
  );

  Map<String, dynamic> toJson() => {
    "info": info?.toJson(),
    "hasCurrent": hasCurrent,
    "config": config,
    "schicht": schicht,
  };
}

class Info {
  final int? id;
  final String? street;
  final String? houseno;
  final int? zip;
  final String? city;
  final String? comment;
  final String? email;
  final String? username;
  final dynamic contactperson;
  final String? phone;
  final double? lat;
  final int? lon;
  final bool? showpausebutton;
  final int? distancetobook;
  final String? name;
  final int? offsetminutes;
  final bool? allowstartingoffset;
  final bool? photoverification;
  final dynamic imageurl;

  Info({
    this.id,
    this.street,
    this.houseno,
    this.zip,
    this.city,
    this.comment,
    this.email,
    this.username,
    this.contactperson,
    this.phone,
    this.lat,
    this.lon,
    this.showpausebutton,
    this.distancetobook,
    this.name,
    this.offsetminutes,
    this.allowstartingoffset,
    this.photoverification,
    this.imageurl,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    id: json["id"],
    street: json["street"],
    houseno: json["houseno"],
    zip: json["zip"],
    city: json["city"],
    comment: json["comment"],
    email: json["email"],
    username: json["username"],
    contactperson: json["contactperson"],
    phone: json["phone"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"],
    showpausebutton: json["showpausebutton"],
    distancetobook: json["distancetobook"],
    name: json["name"],
    offsetminutes: json["offsetminutes"],
    allowstartingoffset: json["allowstartingoffset"],
    photoverification: json["photoverification"],
    imageurl: json["imageurl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "street": street,
    "houseno": houseno,
    "zip": zip,
    "city": city,
    "comment": comment,
    "email": email,
    "username": username,
    "contactperson": contactperson,
    "phone": phone,
    "lat": lat,
    "lon": lon,
    "showpausebutton": showpausebutton,
    "distancetobook": distancetobook,
    "name": name,
    "offsetminutes": offsetminutes,
    "allowstartingoffset": allowstartingoffset,
    "photoverification": photoverification,
    "imageurl": imageurl,
  };
}
