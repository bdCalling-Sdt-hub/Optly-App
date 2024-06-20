class DocsModel {
  final int? id;
  final String? filename;
  final String? groupname;
  final int? createdBy;
  final String? createdAt;
  final String? creator;

  DocsModel({
    this.id,
    this.filename,
    this.groupname,
    this.createdBy,
    this.createdAt,
    this.creator,
  });

  factory DocsModel.fromJson(Map<String, dynamic> json) => DocsModel(
    id: json["id"],
    filename: json["filename"],
    groupname: json["groupname"],
    createdBy: json["created_by"],
    createdAt: json["created_at"],
    creator: json["creator"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "filename": filename,
    "groupname": groupname,
    "created_by": createdBy,
    "created_at": createdAt,
    "creator": creator,
  };
}