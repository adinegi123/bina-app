class bannerModelNew {
  int? status;
  String? message;
  String? result;
  List<Data>? data;

  bannerModelNew({this.status, this.message, this.result, this.data});

  bannerModelNew.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var bannerId;
  String? bannerName;
  var bannerImage;
  String? status;
  String? entrydt;

  Data(
      {this.bannerId,
        this.bannerName,
        this.bannerImage,
        this.status,
        this.entrydt});

  Data.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerName = json['banner_name'];
    bannerImage = json['banner_image'];
    status = json['status'];
    entrydt = json['entrydt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerId;
    data['banner_name'] = this.bannerName;
    data['banner_image'] = this.bannerImage;
    data['status'] = this.status;
    data['entrydt'] = this.entrydt;
    return data;
  }
}
