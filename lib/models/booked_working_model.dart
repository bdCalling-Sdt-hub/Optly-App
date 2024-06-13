
class BookedWorkingModel {
  bool? success;
  Data? data;
  dynamic message;

  BookedWorkingModel({
    this.success,
    this.data,
    this.message,
  });

  factory BookedWorkingModel.fromJson(Map<String, dynamic> json) => BookedWorkingModel(
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
  List<dynamic>? deleted;
  List<Entry>? entries;
  String? breakrules;
  int? subtractbreaks;
  Finalization? finalization;
  bool? daysExceeded;
  bool? hasClosePermisson;
  int? permissionneeded;
  List<dynamic>? vacationdays;
  List<dynamic>? sickdays;
  int? sollMinutes;
  int? sickMinutes;
  int? vacationMinutes;
  int? feiertagMinutes;
  int? minutesPerDay;
  List<Finalizationpermission>? finalizationpermission;
  double? time;

  Data({
    this.deleted,
    this.entries,
    this.breakrules,
    this.subtractbreaks,
    this.finalization,
    this.daysExceeded,
    this.hasClosePermisson,
    this.permissionneeded,
    this.vacationdays,
    this.sickdays,
    this.sollMinutes,
    this.sickMinutes,
    this.vacationMinutes,
    this.feiertagMinutes,
    this.minutesPerDay,
    this.finalizationpermission,
    this.time,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    deleted: json["deleted"] == null ? [] : List<dynamic>.from(json["deleted"]!.map((x) => x)),
    entries: json["entries"] == null ? [] : List<Entry>.from(json["entries"]!.map((x) => Entry.fromJson(x))),
    breakrules: json["breakrules"],
    subtractbreaks: json["subtractbreaks"],
    finalization: json["finalization"]==null?json["finalization"]:Finalization.fromJson(json["finalization"]),
    daysExceeded: json["daysExceeded"],
    hasClosePermisson: json["hasClosePermisson"],
    permissionneeded: json["permissionneeded"],
    vacationdays: json["vacationdays"] == null ? [] : List<dynamic>.from(json["vacationdays"]!.map((x) => x)),
    sickdays: json["sickdays"] == null ? [] : List<dynamic>.from(json["sickdays"]!.map((x) => x)),
    sollMinutes: json["sollMinutes"],
    sickMinutes: json["sickMinutes"],
    vacationMinutes: json["vacationMinutes"],
    feiertagMinutes: json["feiertagMinutes"],
    minutesPerDay: json["minutesPerDay"],
    finalizationpermission: json["finalizationpermission"] == null ? [] : List<Finalizationpermission>.from(json["finalizationpermission"]!.map((x) => Finalizationpermission.fromJson(x))),
    time: json["time"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "deleted": deleted == null ? [] : List<dynamic>.from(deleted!.map((x) => x)),
    "entries": entries == null ? [] : List<dynamic>.from(entries!.map((x) => x.toJson())),
    "breakrules": breakrules,
    "subtractbreaks": subtractbreaks,
    "finalization": finalization,
    "daysExceeded": daysExceeded,
    "hasClosePermisson": hasClosePermisson,
    "permissionneeded": permissionneeded,
    "vacationdays": vacationdays == null ? [] : List<dynamic>.from(vacationdays!.map((x) => x)),
    "sickdays": sickdays == null ? [] : List<dynamic>.from(sickdays!.map((x) => x)),
    "sollMinutes": sollMinutes,
    "sickMinutes": sickMinutes,
    "vacationMinutes": vacationMinutes,
    "feiertagMinutes": feiertagMinutes,
    "minutesPerDay": minutesPerDay,
    "finalizationpermission": finalizationpermission == null ? [] : List<dynamic>.from(finalizationpermission!.map((x) => x.toJson())),
    "time": time,
  };
}

class Entry {
  int? id;
  int? workedtime;
  String? customername;
  String? start;
  String? end;
  int? userid;
  int? customerid;
  int? entryBreak;
  dynamic category;
  int? paused;
  String? breaktimes;
  String? hourlysalary;
  int? month;
  int? year;
  int? creationmethod;
  int? stopmethod;
  String? comment;
  String? extrastring;
  dynamic startimage;
  dynamic endimage;
  int? status;
  DateTime? createdAt;
  int? createdBy;
  DateTime? updatedAt;
  int? updatedBy;

  Entry({
    this.id,
    this.workedtime,
    this.customername,
    this.start,
    this.end,
    this.userid,
    this.customerid,
    this.entryBreak,
    this.category,
    this.paused,
    this.breaktimes,
    this.hourlysalary,
    this.month,
    this.year,
    this.creationmethod,
    this.stopmethod,
    this.comment,
    this.extrastring,
    this.startimage,
    this.endimage,
    this.status,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
    id: json["id"],
    workedtime: json["workedtime"],
    customername: json["customername"],
    start: json["start"]??"",
    end: json["end"]??"",
    userid: json["userid"],
    customerid: json["customerid"],
    entryBreak: json["break"],
    category: json["category"],
    paused: json["paused"],
    breaktimes: json["breaktimes"],
    hourlysalary: json["hourlysalary"],
    month: json["month"],
    year: json["year"],
    creationmethod: json["creationmethod"],
    stopmethod: json["stopmethod"],
    comment: json["comment"],
    extrastring: json["extrastring"],
    startimage: json["startimage"],
    endimage: json["endimage"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedBy: json["updated_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workedtime": workedtime,
    "customername": customername,
    "start": start,
    "end": end,
    "userid": userid,
    "customerid": customerid,
    "break": entryBreak,
    "category": category,
    "paused": paused,
    "breaktimes": breaktimes,
    "hourlysalary": hourlysalary,
    "month": month,
    "year": year,
    "creationmethod": creationmethod,
    "stopmethod": stopmethod,
    "comment": comment,
    "extrastring": extrastring,
    "startimage": startimage,
    "endimage": endimage,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "updated_at": updatedAt?.toIso8601String(),
    "updated_by": updatedBy,
  };
}

class Finalizationpermission {
  int? id;
  int? userid;
  DateTime? permissionAt;
  int? permissionBy;
  int? month;
  int? year;

  Finalizationpermission({
    this.id,
    this.userid,
    this.permissionAt,
    this.permissionBy,
    this.month,
    this.year,
  });

  factory Finalizationpermission.fromJson(Map<String, dynamic> json) => Finalizationpermission(
    id: json["id"],
    userid: json["userid"],
    permissionAt: json["permission_at"] == null ? null : DateTime.parse(json["permission_at"]),
    permissionBy: json["permission_by"],
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "permission_at": permissionAt?.toIso8601String(),
    "permission_by": permissionBy,
    "month": month,
    "year": year,
  };
}


class Finalization {
  int? id;
  int? status;
  int? createdBy;
  String? createdAt;

  Finalization({
    this.id,
    this.status,
    this.createdBy,
    this.createdAt,
  });

  factory Finalization.fromJson(Map<String, dynamic> json) => Finalization(
    id: json["id"],
    status: json["status"],
    createdBy: json["created_by"],
    createdAt: json["created_at"],
  );


}

