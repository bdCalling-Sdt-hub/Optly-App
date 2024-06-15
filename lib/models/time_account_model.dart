
class TimeAccountModel {
  final int? id;
  final int? userid;
  final int? month;
  final int? year;
  final int? overhours;
  final int? finalid;
  final dynamic description;
  final dynamic createdBy;
  final String? createdAt;

  TimeAccountModel({
    this.id,
    this.userid,
    this.month,
    this.year,
    this.overhours,
    this.finalid,
    this.description,
    this.createdBy,
    this.createdAt,
  });

  factory TimeAccountModel.fromJson(Map<String, dynamic> json) => TimeAccountModel(
    id: json["id"],
    userid: json["userid"],
    month: json["month"],
    year: json["year"],
    overhours: json["overhours"],
    finalid: json["finalid"],
    description: json["description"],
    createdBy: json["created_by"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "month": month,
    "year": year,
    "overhours": overhours,
    "finalid": finalid,
    "description": description,
    "created_by": createdBy,
    "created_at": createdAt,
  };
}
