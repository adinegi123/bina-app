// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.result,
    required this.message,
    required this.status,
  });

  List<Result> result;
  String message;
  int status;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
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
    required this.categoryId,
    required this.categoryName,
    required this.categoryNameAr,
    required this.categoryImage,
    required this.status,
    required this.entrydt,
  });

  String categoryId;
  String categoryName;
  String categoryNameAr;
  String categoryImage;
  String status;
  DateTime entrydt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    categoryNameAr: json["category_name_ar"],
    categoryImage: json["category_image"],
    status: json["status"],
    entrydt: DateTime.parse(json["entrydt"]),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_name_ar": categoryNameAr,
    "category_image": categoryImage,
    "status": status,
    "entrydt": entrydt.toIso8601String(),
  };
}
