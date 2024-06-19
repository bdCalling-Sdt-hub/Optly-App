

class AbsenceModel {
  final bool? success;
  final Data? data;
  final dynamic message;

  AbsenceModel({
    this.success,
    this.data,
    this.message,
  });

  factory AbsenceModel.fromJson(Map<String, dynamic> json) => AbsenceModel(
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
  final List<Absence>? absence;
  final List<Absence>? sick;
  final List<dynamic>? open;
  final int? dayswithoutAu;
  final List<dynamic>? opensick;
  final Summary? summary;
  final Regularfeiertage? regularfeiertage;
  final List<dynamic>? specialfeiertage;
  final double? time;

  Data({
    this.absence,
    this.sick,
    this.open,
    this.dayswithoutAu,
    this.opensick,
    this.summary,
    this.regularfeiertage,
    this.specialfeiertage,
    this.time,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    absence: json["absence"] == null ? [] : List<Absence>.from(json["absence"]!.map((x) => Absence.fromJson(x))),
    sick: json["sick"] == null ? [] : List<Absence>.from(json["sick"]!.map((x) => Absence.fromJson(x))),
    open: json["open"] == null ? [] : List<dynamic>.from(json["open"]!.map((x) => x)),
    dayswithoutAu: json["dayswithoutAU"],
    opensick: json["opensick"] == null ? [] : List<dynamic>.from(json["opensick"]!.map((x) => x)),
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    regularfeiertage: json["regularfeiertage"] == null ? null : Regularfeiertage.fromJson(json["regularfeiertage"]),
    specialfeiertage: json["specialfeiertage"] == null ? [] : List<dynamic>.from(json["specialfeiertage"]!.map((x) => x)),
    time: json["time"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "absence": absence == null ? [] : List<dynamic>.from(absence!.map((x) => x.toJson())),
    "sick": sick == null ? [] : List<dynamic>.from(sick!.map((x) => x.toJson())),
    "open": open == null ? [] : List<dynamic>.from(open!.map((x) => x)),
    "dayswithoutAU": dayswithoutAu,
    "opensick": opensick == null ? [] : List<dynamic>.from(opensick!.map((x) => x)),
    "summary": summary?.toJson(),
    "regularfeiertage": regularfeiertage?.toJson(),
    "specialfeiertage": specialfeiertage == null ? [] : List<dynamic>.from(specialfeiertage!.map((x) => x)),
    "time": time,
  };
}

class Absence {
  final int? id;
  final int? userid;
  final DateTime? startdate;
  final DateTime? enddate;
  final int? status;
  final String? description;
  final String? type;
  final dynamic duration;
  final dynamic supervisorid;
  final DateTime? createdAt;
  final int? createdBy;
  final DateTime? updatedAt;
  final dynamic updatedBy;
  final int? docid;
  final String? name;
  final String? filename;

  Absence({
    this.id,
    this.userid,
    this.startdate,
    this.enddate,
    this.status,
    this.description,
    this.type,
    this.duration,
    this.supervisorid,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.docid,
    this.name,
    this.filename,
  });

  factory Absence.fromJson(Map<String, dynamic> json) => Absence(
    id: json["id"],
    userid: json["userid"],
    startdate: json["startdate"] == null ? null : DateTime.parse(json["startdate"]),
    enddate: json["enddate"] == null ? null : DateTime.parse(json["enddate"]),
    status: json["status"],
    description: json["description"],
    type: json["type"],
    duration: json["duration"],
    supervisorid: json["supervisorid"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedBy: json["updated_by"],
    docid: json["docid"],
    name: json["name"],
    filename: json["filename"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "startdate": "${startdate!.year.toString().padLeft(4, '0')}-${startdate!.month.toString().padLeft(2, '0')}-${startdate!.day.toString().padLeft(2, '0')}",
    "enddate": "${enddate!.year.toString().padLeft(4, '0')}-${enddate!.month.toString().padLeft(2, '0')}-${enddate!.day.toString().padLeft(2, '0')}",
    "status": status,
    "description": description,
    "type": type,
    "duration": duration,
    "supervisorid": supervisorid,
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "updated_at": updatedAt?.toIso8601String(),
    "updated_by": updatedBy,
    "docid": docid,
    "name": name,
    "filename": filename,
  };
}

class Regularfeiertage {
  final String? the06012024;
  final String? the09012024;

  Regularfeiertage({
    this.the06012024,
    this.the09012024,
  });

  factory Regularfeiertage.fromJson(Map<String, dynamic> json) => Regularfeiertage(
    the06012024: json["06.01.2024"],
    the09012024: json["09.01.2024"],
  );

  Map<String, dynamic> toJson() => {
    "06.01.2024": the06012024,
    "09.01.2024": the09012024,
  };
}

class Summary {
  final int? hourlybasispayable;
  final String? workingdays;
  final int? userid;
  final int? vacationdays;
  final dynamic vacation;
  final dynamic duration;
  final int? open;

  Summary({
    this.hourlybasispayable,
    this.workingdays,
    this.userid,
    this.vacationdays,
    this.vacation,
    this.duration,
    this.open,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    hourlybasispayable: json["hourlybasispayable"],
    workingdays: json["workingdays"],
    userid: json["userid"],
    vacationdays: json["vacationdays"],
    vacation: json["vacation"],
    duration: json["duration"],
    open: json["open"],
  );

  Map<String, dynamic> toJson() => {
    "hourlybasispayable": hourlybasispayable,
    "workingdays": workingdays,
    "userid": userid,
    "vacationdays": vacationdays,
    "vacation": vacation,
    "duration": duration,
    "open": open,
  };
}
