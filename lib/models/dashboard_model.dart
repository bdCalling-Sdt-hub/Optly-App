
class DashboardModel {
  final bool? success;
  final Data? data;
  final dynamic message;

  DashboardModel({
    this.success,
    this.data,
    this.message,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
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
  final List<Current>? currents;
  final String? currentminutes;
  final dynamic duration;
  final double? time;
  final List<Finalization>? finalizations;
  final List<dynamic>? schichten;
  final int? allowstop;
  final int? subtractbreaks;
  final bool? showbookedtimes;
  final List<dynamic>? hygieneplans;
  final List<Todo>? todos;
  final List<dynamic>? notes;

  Data({
    this.currents,
    this.currentminutes,
    this.duration,
    this.time,
    this.finalizations,
    this.schichten,
    this.allowstop,
    this.subtractbreaks,
    this.showbookedtimes,
    this.hygieneplans,
    this.todos,
    this.notes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currents: json["currents"] == null ? [] : List<Current>.from(json["currents"]!.map((x) => Current.fromJson(x))),
    currentminutes: json["currentminutes"],
    duration: json["duration"],
    time: json["time"]?.toDouble(),
    finalizations: json["finalizations"] == null ? [] : List<Finalization>.from(json["finalizations"]!.map((x) => Finalization.fromJson(x))),
    schichten: json["schichten"] == null ? [] : List<dynamic>.from(json["schichten"]!.map((x) => x)),
    allowstop: json["allowstop"],
    subtractbreaks: json["subtractbreaks"],
    showbookedtimes: json["showbookedtimes"],
    hygieneplans: json["hygieneplans"] == null ? [] : List<dynamic>.from(json["hygieneplans"]!.map((x) => x)),
    todos: json["todos"] == null ? [] : List<Todo>.from(json["todos"]!.map((x) => Todo.fromJson(x))),
    notes: json["notes"] == null ? [] : List<dynamic>.from(json["notes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "currents": currents == null ? [] : List<dynamic>.from(currents!.map((x) => x.toJson())),
    "currentminutes": currentminutes,
    "duration": duration,
    "time": time,
    "finalizations": finalizations == null ? [] : List<dynamic>.from(finalizations!.map((x) => x.toJson())),
    "schichten": schichten == null ? [] : List<dynamic>.from(schichten!.map((x) => x)),
    "allowstop": allowstop,
    "subtractbreaks": subtractbreaks,
    "showbookedtimes": showbookedtimes,
    "hygieneplans": hygieneplans == null ? [] : List<dynamic>.from(hygieneplans!.map((x) => x)),
    "todos": todos == null ? [] : List<dynamic>.from(todos!.map((x) => x.toJson())),
    "notes": notes == null ? [] : List<dynamic>.from(notes!.map((x) => x)),
  };
}

class Current {
  final int? id;
  final DateTime? start;
  final dynamic end;
  final int? userid;
  final int? customerid;
  final dynamic currentBreak;
  final int? paused;
  final String? breaktimes;
  final String? hourlysalary;
  final int? month;
  final int? year;
  final int? creationmethod;
  final dynamic stopmethod;
  final int? duration;
  final dynamic category;
  final String? comment;
  final dynamic extrastring;
  final dynamic startimage;
  final dynamic endimage;
  final int? status;
  final DateTime? createdAt;
  final int? createdBy;
  final DateTime? updatedAt;
  final int? updatedBy;
  final String? cname;
  final int? distancetobook;
  final String? lat;
  final String? lon;
  final int? showpausebutton;
  final int? photoverification;

  Current({
    this.id,
    this.start,
    this.end,
    this.userid,
    this.customerid,
    this.currentBreak,
    this.paused,
    this.breaktimes,
    this.hourlysalary,
    this.month,
    this.year,
    this.creationmethod,
    this.stopmethod,
    this.duration,
    this.category,
    this.comment,
    this.extrastring,
    this.startimage,
    this.endimage,
    this.status,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.cname,
    this.distancetobook,
    this.lat,
    this.lon,
    this.showpausebutton,
    this.photoverification,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    id: json["id"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"],
    userid: json["userid"],
    customerid: json["customerid"],
    currentBreak: json["break"],
    paused: json["paused"],
    breaktimes: json["breaktimes"],
    hourlysalary: json["hourlysalary"],
    month: json["month"],
    year: json["year"],
    creationmethod: json["creationmethod"],
    stopmethod: json["stopmethod"],
    duration: json["duration"],
    category: json["category"],
    comment: json["comment"],
    extrastring: json["extrastring"],
    startimage: json["startimage"],
    endimage: json["endimage"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedBy: json["updated_by"],
    cname: json["cname"],
    distancetobook: json["distancetobook"],
    lat: json["lat"],
    lon: json["lon"],
    showpausebutton: json["showpausebutton"],
    photoverification: json["photoverification"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start": start?.toIso8601String(),
    "end": end,
    "userid": userid,
    "customerid": customerid,
    "break": currentBreak,
    "paused": paused,
    "breaktimes": breaktimes,
    "hourlysalary": hourlysalary,
    "month": month,
    "year": year,
    "creationmethod": creationmethod,
    "stopmethod": stopmethod,
    "duration": duration,
    "category": category,
    "comment": comment,
    "extrastring": extrastring,
    "startimage": startimage,
    "endimage": endimage,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "updated_at": updatedAt?.toIso8601String(),
    "updated_by": updatedBy,
    "cname": cname,
    "distancetobook": distancetobook,
    "lat": lat,
    "lon": lon,
    "showpausebutton": showpausebutton,
    "photoverification": photoverification,
  };
}

class Finalization {
  final int? userid;
  final String? yearmonth;
  final dynamic createdAtList;
  final dynamic yearList;
  final dynamic monthList;

  Finalization({
    this.userid,
    this.yearmonth,
    this.createdAtList,
    this.yearList,
    this.monthList,
  });

  factory Finalization.fromJson(Map<String, dynamic> json) => Finalization(
    userid: json["userid"],
    yearmonth: json["yearmonth"],
    createdAtList: json["created_at_list"],
    yearList: json["year_list"],
    monthList: json["month_list"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "yearmonth": yearmonth,
    "created_at_list": createdAtList,
    "year_list": yearList,
    "month_list": monthList,
  };
}

class Todo {
  final int? id;
  final String? description;
  final String? title;

  Todo({
    this.id,
    this.description,
    this.title,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["id"],
    description: json["description"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "title": title,
  };
}
