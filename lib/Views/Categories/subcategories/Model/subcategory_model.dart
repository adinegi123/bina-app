class subcategoryModelClass {
  List<Result>? result;
  String? message;
  var status;

  subcategoryModelClass({this.result, this.message, this.status});

  subcategoryModelClass.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Result {
  String? subCategoryId;
  String? categoryId;
  String? subCategoryName;
  String? subCategoryNameAr;
  String? status;
  String? entrydt;
  String? categoryName;

  Result(
      {this.subCategoryId,
        this.categoryId,
        this.subCategoryName,
        this.subCategoryNameAr,
        this.status,
        this.entrydt,
        this.categoryName});

  Result.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    subCategoryName = json['sub_category_name'];
    subCategoryNameAr = json['sub_category_name_ar'];
    status = json['status'];
    entrydt = json['entrydt'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['sub_category_name'] = this.subCategoryName;
    data['sub_category_name_ar'] = this.subCategoryNameAr;
    data['status'] = this.status;
    data['entrydt'] = this.entrydt;
    data['category_name'] = this.categoryName;
    return data;
  }
}
