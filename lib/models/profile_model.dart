

class ProfileModel {
  final bool? success;
  final Data? data;
  final dynamic message;

  ProfileModel({
    this.success,
    this.data,
    this.message,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  final List<Customer>? customers;
  final List<Workercategory>? workercategory;
  final bool? showbookedtimes;
  final List<Supervisor>? supervisors;

  Data({
    this.info,
    this.customers,
    this.workercategory,
    this.showbookedtimes,
    this.supervisors,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    info: json["info"] == null ? null : Info.fromJson(json["info"]),
    customers: json["customers"] == null ? [] : List<Customer>.from(json["customers"]!.map((x) => Customer.fromJson(x))),
     workercategory: json["workercategory"] == null ? [] : List<Workercategory>.from(json["workercategory"]!.map((x) => Workercategory.fromJson(x))),
       showbookedtimes: json["showbookedtimes"],
    supervisors: json["supervisors"] == null ? [] : List<Supervisor>.from(json["supervisors"]!.map((x) => Supervisor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "info": info?.toJson(),
    "customers": customers == null ? [] : List<dynamic>.from(customers!.map((x) => x.toJson())),
    "workercategory": workercategory == null ? [] : List<dynamic>.from(workercategory!.map((x) => x.toJson())),
    "showbookedtimes": showbookedtimes,
    "supervisors": supervisors == null ? [] : List<dynamic>.from(supervisors!.map((x) => x.toJson())),
  };
}

class Customer {
  final int? id;
  final String? street;
  final String? houseno;
  final int? zip;
  final String? city;
  final String? comment;
  final String? email;
  final String? username;
  final String? contactperson;
  final String? phone;
  final double? lat;
  final double? lon;
  final bool? showpausebutton;
  final int? distancetobook;
  final String? name;
  final int? offsetminutes;
  final bool? photoverification;
  final String? imageurl;

  Customer({
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
    this.photoverification,
    this.imageurl,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
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
    lon: json["lon"]?.toDouble(),
    showpausebutton: json["showpausebutton"],
    distancetobook: json["distancetobook"],
    name: json["name"],
    offsetminutes: json["offsetminutes"],
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
    "photoverification": photoverification,
    "imageurl": imageurl,
  };
}

class Info {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? name;
  final String? email;
  final String? username;
  final dynamic familystatus;
  final String? phone;
  final String? role;
  late  String? imageurl;
  final String? gender;
  final String? street;
  final String? houseno;
  final int? zip;
  final String? city;
  final int? companyid;
  final dynamic companyuuid;
  final String? employeenumber;
  final DateTime? bday;
  final String? year;
  final String? month;
  final String? day;
  final dynamic supervisorid;
  final dynamic cosupervisorid;
  final String? entrydate;
  final String? exitdate;
  final String? location;
  final dynamic workinghours;
  final dynamic workingweek;
  final List<int>? workingdays;
  final int? salary;
  final int? monthsalary;
  final int? hourlybasispayable;
  final bool? payholidays;
  final dynamic description;
  final int? worktype;
  final List<dynamic>? workercategories;
  final dynamic availabilitytemplate;
  final List<dynamic>? customers;
  final int? vacation;
  final bool? active;
  final String? versicherungsnummer;
  final dynamic birthplace;
  final String? birthcountry;
  final dynamic iban;
  final dynamic bic;
  final dynamic disabled;
  final dynamic citizen;
  final String? countrycode;
  final String? jobtitle;
  final dynamic graduation;
  final dynamic profession;
  final String? steuerid;
  final dynamic kinderfreibetrag;
  final dynamic steuerklasse;
  final dynamic konfession;
  final String? insurancetype;
  final String? insurancename;
  final bool? applyrentenversicherung;
  final dynamic workplace;
  final dynamic occupation;
  final dynamic message;
  final dynamic selectedareas;
  final dynamic otherfrom;
  final dynamic otherto;
  final dynamic otheremployer;
  final dynamic otherworktype;
  final dynamic otherworkinghours;
  final dynamic otherfrom2;
  final dynamic otherto2;
  final dynamic otheremployer2;
  final dynamic otherworkinghours2;
  final dynamic befreiungsantragreceivedAt;
  final dynamic befreiungsantrageffectAt;
  final bool? nachweiseerbracht;
  final dynamic extras;
  final DateTime? signedAt;
  final dynamic befreiungsignedAt;
  final DateTime? sendsigncontractAt;
  final DateTime? sofortmeldungsignedAt;
  final dynamic personalcode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic updatedBy;
  final dynamic bookedtime;

  Info({
    this.id,
    this.firstname,
    this.lastname,
    this.name,
    this.email,
    this.username,
    this.familystatus,
    this.phone,
    this.role,
    this.imageurl,
    this.gender,
    this.street,
    this.houseno,
    this.zip,
    this.city,
    this.companyid,
    this.companyuuid,
    this.employeenumber,
    this.bday,
    this.year,
    this.month,
    this.day,
    this.supervisorid,
    this.cosupervisorid,
    this.entrydate,
    this.exitdate,
    this.location,
    this.workinghours,
    this.workingweek,
    this.workingdays,
    this.salary,
    this.monthsalary,
    this.hourlybasispayable,
    this.payholidays,
    this.description,
    this.worktype,
    this.workercategories,
    this.availabilitytemplate,
    this.customers,
    this.vacation,
    this.active,
    this.versicherungsnummer,
    this.birthplace,
    this.birthcountry,
    this.iban,
    this.bic,
    this.disabled,
    this.citizen,
    this.countrycode,
    this.jobtitle,
    this.graduation,
    this.profession,
    this.steuerid,
    this.kinderfreibetrag,
    this.steuerklasse,
    this.konfession,
    this.insurancetype,
    this.insurancename,
    this.applyrentenversicherung,
    this.workplace,
    this.occupation,
    this.message,
    this.selectedareas,
    this.otherfrom,
    this.otherto,
    this.otheremployer,
    this.otherworktype,
    this.otherworkinghours,
    this.otherfrom2,
    this.otherto2,
    this.otheremployer2,
    this.otherworkinghours2,
    this.befreiungsantragreceivedAt,
    this.befreiungsantrageffectAt,
    this.nachweiseerbracht,
    this.extras,
    this.signedAt,
    this.befreiungsignedAt,
    this.sendsigncontractAt,
    this.sofortmeldungsignedAt,
    this.personalcode,
    this.createdAt,
    this.updatedAt,
    this.updatedBy,
    this.bookedtime,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    name: json["name"],
    email: json["email"],
    username: json["username"],
    familystatus: json["familystatus"],
    phone: json["phone"],
    role: json["role"],
    imageurl: json["imageurl"],
    gender: json["gender"],
    street: json["street"],
    houseno: json["houseno"],
    zip: json["zip"],
    city: json["city"],
    companyid: json["companyid"],
    companyuuid: json["companyuuid"],
    employeenumber: json["employeenumber"],
    bday: json["bday"] == null ? null : DateTime.parse(json["bday"]),
    year: json["year"],
    month: json["month"],
    day: json["day"],
    supervisorid: json["supervisorid"],
    cosupervisorid: json["cosupervisorid"],
    entrydate: json["entrydate"],
    exitdate: json["exitdate"],
    location: json["location"],
    workinghours: json["workinghours"],
    workingweek: json["workingweek"],
    workingdays: json["workingdays"] == null ? [] : List<int>.from(json["workingdays"]!.map((x) => x)),
    salary: json["salary"],
    monthsalary: json["monthsalary"],
    hourlybasispayable: json["hourlybasispayable"],
    payholidays: json["payholidays"],
    description: json["description"],
    worktype: json["worktype"],
    workercategories: json["workercategories"] == null ? [] : List<dynamic>.from(json["workercategories"]!.map((x) => x)),
    availabilitytemplate: json["availabilitytemplate"],
    customers: json["customers"] == null ? [] : List<dynamic>.from(json["customers"]!.map((x) => x)),
    vacation: json["vacation"],
    active: json["active"],
    versicherungsnummer: json["versicherungsnummer"],
    birthplace: json["birthplace"],
    birthcountry: json["birthcountry"],
    iban: json["iban"],
    bic: json["bic"],
    disabled: json["disabled"],
    citizen: json["citizen"],
    countrycode: json["countrycode"],
    jobtitle: json["jobtitle"],
    graduation: json["graduation"],
    profession: json["profession"],
    steuerid: json["steuerid"],
    kinderfreibetrag: json["kinderfreibetrag"],
    steuerklasse: json["steuerklasse"],
    konfession: json["konfession"],
    insurancetype: json["insurancetype"],
    insurancename: json["insurancename"],
    applyrentenversicherung: json["applyrentenversicherung"],
    workplace: json["workplace"],
    occupation: json["occupation"],
    message: json["message"],
    selectedareas: json["selectedareas"],
    otherfrom: json["otherfrom"],
    otherto: json["otherto"],
    otheremployer: json["otheremployer"],
    otherworktype: json["otherworktype"],
    otherworkinghours: json["otherworkinghours"],
    otherfrom2: json["otherfrom2"],
    otherto2: json["otherto2"],
    otheremployer2: json["otheremployer2"],
    otherworkinghours2: json["otherworkinghours2"],
    befreiungsantragreceivedAt: json["befreiungsantragreceived_at"],
    befreiungsantrageffectAt: json["befreiungsantrageffect_at"],
    nachweiseerbracht: json["nachweiseerbracht"],
    extras: json["extras"],
    signedAt: json["signed_at"] == null ? null : DateTime.parse(json["signed_at"]),
    befreiungsignedAt: json["befreiungsigned_at"],
    sendsigncontractAt: json["sendsigncontract_at"] == null ? null : DateTime.parse(json["sendsigncontract_at"]),
    sofortmeldungsignedAt: json["sofortmeldungsigned_at"] == null ? null : DateTime.parse(json["sofortmeldungsigned_at"]),
    personalcode: json["personalcode"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedBy: json["updated_by"],
    bookedtime: json["bookedtime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "name": name,
    "email": email,
    "username": username,
    "familystatus": familystatus,
    "phone": phone,
    "role": role,
    "imageurl": imageurl,
    "gender": gender,
    "street": street,
    "houseno": houseno,
    "zip": zip,
    "city": city,
    "companyid": companyid,
    "companyuuid": companyuuid,
    "employeenumber": employeenumber,
    "bday": "${bday!.year.toString().padLeft(4, '0')}-${bday!.month.toString().padLeft(2, '0')}-${bday!.day.toString().padLeft(2, '0')}",
    "year": year,
    "month": month,
    "day": day,
    "supervisorid": supervisorid,
    "cosupervisorid": cosupervisorid,
    "location": location,
    "workinghours": workinghours,
    "workingweek": workingweek,
    "workingdays": workingdays == null ? [] : List<dynamic>.from(workingdays!.map((x) => x)),
    "salary": salary,
    "monthsalary": monthsalary,
    "hourlybasispayable": hourlybasispayable,
    "payholidays": payholidays,
    "description": description,
    "worktype": worktype,
    "workercategories": workercategories == null ? [] : List<dynamic>.from(workercategories!.map((x) => x)),
    "availabilitytemplate": availabilitytemplate,
    "customers": customers == null ? [] : List<dynamic>.from(customers!.map((x) => x)),
    "vacation": vacation,
    "active": active,
    "versicherungsnummer": versicherungsnummer,
    "birthplace": birthplace,
    "birthcountry": birthcountry,
    "iban": iban,
    "bic": bic,
    "disabled": disabled,
    "citizen": citizen,
    "countrycode": countrycode,
    "jobtitle": jobtitle,
    "graduation": graduation,
    "profession": profession,
    "steuerid": steuerid,
    "kinderfreibetrag": kinderfreibetrag,
    "steuerklasse": steuerklasse,
    "konfession": konfession,
    "insurancetype": insurancetype,
    "insurancename": insurancename,
    "applyrentenversicherung": applyrentenversicherung,
    "workplace": workplace,
    "occupation": occupation,
    "message": message,
    "selectedareas": selectedareas,
    "otherfrom": otherfrom,
    "otherto": otherto,
    "otheremployer": otheremployer,
    "otherworktype": otherworktype,
    "otherworkinghours": otherworkinghours,
    "otherfrom2": otherfrom2,
    "otherto2": otherto2,
    "otheremployer2": otheremployer2,
    "otherworkinghours2": otherworkinghours2,
    "befreiungsantragreceived_at": befreiungsantragreceivedAt,
    "befreiungsantrageffect_at": befreiungsantrageffectAt,
    "nachweiseerbracht": nachweiseerbracht,
    "extras": extras,
    "signed_at": signedAt?.toIso8601String(),
    "befreiungsigned_at": befreiungsignedAt,
    "sendsigncontract_at": sendsigncontractAt?.toIso8601String(),
    "sofortmeldungsigned_at": sofortmeldungsignedAt?.toIso8601String(),
    "personalcode": personalcode,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "updated_by": updatedBy,
    "bookedtime": bookedtime,
  };
}

class Supervisor {
  final int? id;
  final String? name;

  Supervisor({
    this.id,
    this.name,
  });

  factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Workercategory {
  final String? color;
  final String? title;

  Workercategory({
    this.color,
    this.title,
  });

  factory Workercategory.fromJson(Map<String, dynamic> json) => Workercategory(
    color: json["color"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "title": title,
  };
}
