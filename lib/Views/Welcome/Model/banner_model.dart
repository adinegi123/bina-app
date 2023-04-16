import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    required this.result,
    required this.message,
    required this.status,
  });

  List<Result> result;
  String message;
  int status;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    result:
    List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class Result {
  Result({
    required this.bannerId,
    required this.bannerName,
    required this.bannerImage,
    required this.status,
    required this.entrydt,
  });

  String bannerId;
  String bannerName;
  String bannerImage;
  String status;
  DateTime entrydt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    bannerId: json["banner_id"],
    bannerName: json["banner_name"],
    bannerImage: json["banner_image"],
    status: json["status"],
    entrydt: DateTime.parse(json["entrydt"]),
  );

  Map<String, dynamic> toJson() => {
    "banner_id": bannerId,
    "banner_name": bannerName,
    "banner_image": bannerImage,
    "status": status,
    "entrydt": entrydt.toIso8601String(),
  };
}
