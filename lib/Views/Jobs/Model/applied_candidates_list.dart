class candidateListModel {
  List<Data>? data;
  String? message;
  bool? status;

  candidateListModel({this.data, this.message, this.status});

  candidateListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? userId;
  String? name;
  String? city;
  String? userImage;
  String? resume;
  String? totalExperienceYear;

  Data(
      {this.userId,
        this.name,
        this.city,
        this.userImage,
        this.resume,
        this.totalExperienceYear});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    city = json['city'];
    userImage = json['user_image'];
    resume = json['resume'];
    totalExperienceYear = json['total_experience_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['city'] = this.city;
    data['user_image'] = this.userImage;
    data['resume'] = this.resume;
    data['total_experience_year'] = this.totalExperienceYear;
    return data;
  }
}
