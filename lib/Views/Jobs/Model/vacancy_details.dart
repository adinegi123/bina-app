class vaccancyDetailsModelData {
  List<Data>? data;
  bool? status;

  vaccancyDetailsModelData({this.data, this.status});

  vaccancyDetailsModelData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  Details? details;
  String? averageRating;

  Data({this.details, this.averageRating});

  Data.fromJson(Map<String, dynamic> json) {
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    averageRating = json['averageRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['averageRating'] = this.averageRating;
    return data;
  }
}

class Details {
  String? userId;
  String? membershipId;
  String? name;
  String? address;
  String? country;
  String? state;
  String? sinceYear;
  String? mobile;
  String? shortBio;
  String? website;
  String? userImage;
  String? jobDescription;
  String? minimumExperienceMonth;
  String? minimumExperienceYear;
  String? rolesResponsibility;

  Details(
      {this.userId,
        this.membershipId,
        this.name,
        this.address,
        this.country,
        this.state,
        this.sinceYear,
        this.mobile,
        this.shortBio,
        this.website,
        this.userImage,
        this.jobDescription,
        this.minimumExperienceMonth,
        this.minimumExperienceYear,
        this.rolesResponsibility});

  Details.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    membershipId = json['membership_id'];
    name = json['name'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    sinceYear = json['since_year'];
    mobile = json['mobile'];
    shortBio = json['short_bio'];
    website = json['website'];
    userImage = json['user_image'];
    jobDescription = json['job_description'];
    minimumExperienceMonth = json['minimum_experience_month'];
    minimumExperienceYear = json['minimum_experience_year'];
    rolesResponsibility = json['roles_responsibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['membership_id'] = this.membershipId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['since_year'] = this.sinceYear;
    data['mobile'] = this.mobile;
    data['short_bio'] = this.shortBio;
    data['website'] = this.website;
    data['user_image'] = this.userImage;
    data['job_description'] = this.jobDescription;
    data['minimum_experience_month'] = this.minimumExperienceMonth;
    data['minimum_experience_year'] = this.minimumExperienceYear;
    data['roles_responsibility'] = this.rolesResponsibility;
    return data;
  }
}
