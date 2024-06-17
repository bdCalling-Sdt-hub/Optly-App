
class MySchedulePlanModel {
  final bool? success;
  final Data? data;
  final dynamic message;

  MySchedulePlanModel({
    this.success,
    this.data,
    this.message,
  });

  factory MySchedulePlanModel.fromJson(Map<String, dynamic> json) => MySchedulePlanModel(
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
  final List<Schichten>? schichten;
  final String? usercustomers;
  final List<Customer>? customers;
  final String? categories;

  Data({
    this.info,
    this.schichten,
    this.usercustomers,
    this.customers,
    this.categories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    info: json["info"] == null ? null : Info.fromJson(json["info"]),
    schichten: json["schichten"] == null ? [] : List<Schichten>.from(json["schichten"]!.map((x) => Schichten.fromJson(x))),
    usercustomers: json["usercustomers"],
    customers: json["customers"] == null ? [] : List<Customer>.from(json["customers"]!.map((x) => Customer.fromJson(x))),
    categories: json["categories"],
  );

  Map<String, dynamic> toJson() => {
    "info": info?.toJson(),
    "schichten": schichten == null ? [] : List<dynamic>.from(schichten!.map((x) => x.toJson())),
    "usercustomers": usercustomers,
    "customers": customers == null ? [] : List<dynamic>.from(customers!.map((x) => x.toJson())),
    "categories": categories,
  };
}

class Customer {
  final String? name;
  final int? id;

  Customer({
    this.name,
    this.id,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}

class Info {
  final int? id;
  final int? companyid;
  final String? name;
  final DateTime? start;
  final DateTime? end;
  final String? metainfo;
  final int? status;
  final int? available;
  final DateTime? createdAt;
  final int? createdBy;
  final DateTime? updatedAt;
  final int? updatedBy;
  final String? workercategory;
  final int? approveschicht;

  Info({
    this.id,
    this.companyid,
    this.name,
    this.start,
    this.end,
    this.metainfo,
    this.status,
    this.available,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.workercategory,
    this.approveschicht,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    id: json["id"],
    companyid: json["companyid"],
    name: json["name"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    metainfo: json["metainfo"],
    status: json["status"],
    available: json["available"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedBy: json["updated_by"],
    workercategory: json["workercategory"],
    approveschicht: json["approveschicht"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyid": companyid,
    "name": name,
    "start": "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
    "end": "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
    "metainfo": metainfo,
    "status": status,
    "available": available,
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "updated_at": updatedAt?.toIso8601String(),
    "updated_by": updatedBy,
    "workercategory": workercategory,
    "approveschicht": approveschicht,
  };
}

class Schichten {
  final int? customerid;
  final int? status;
  final int? id;
  final String? name;
  final DateTime? date;
  final String? endtime;
  final String? starttime;
  final int? userid;
  final dynamic comment;
  final String? category;
  final int? schichtplanid;
  final String? standortname;
  final String? username;

  Schichten({
    this.customerid,
    this.status,
    this.id,
    this.name,
    this.date,
    this.endtime,
    this.starttime,
    this.userid,
    this.comment,
    this.category,
    this.schichtplanid,
    this.standortname,
    this.username,
  });

  factory Schichten.fromJson(Map<String, dynamic> json) => Schichten(
    customerid: json["customerid"],
    status: json["status"],
    id: json["id"],
    name: json["name"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    endtime: json["endtime"],
    starttime: json["starttime"],
    userid: json["userid"],
    comment: json["comment"],
    category: json["category"],
    schichtplanid: json["schichtplanid"],
    standortname: json["standortname"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "customerid": customerid,
    "status": status,
    "id": id,
    "name": name,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "endtime": endtime,
    "starttime": starttime,
    "userid": userid,
    "comment": comment,
    "category": category,
    "schichtplanid": schichtplanid,
    "standortname": standortname,
    "username": username,
  };
}
