class appliedCandidateDetailsModel {
  List<AppiledList>? appiledList;
  bool? status;

  appliedCandidateDetailsModel({this.appiledList, this.status});

  appliedCandidateDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['appiled_list'] != null) {
      appiledList = <AppiledList>[];
      json['appiled_list'].forEach((v) {
        appiledList!.add(new AppiledList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appiledList != null) {
      data['appiled_list'] = this.appiledList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class AppiledList {
  String? name;
  String? email;
  String? mobile;
  String? createdAt;
  String? totalExperienceYear;
  String? qualification;
  String? expectedSalary;
  String? city;
  String? userImage;
  String? jobsType;
  String? resume;

  AppiledList(
      {this.name,
        this.email,
        this.mobile,
        this.createdAt,
        this.totalExperienceYear,
        this.qualification,
        this.expectedSalary,
        this.city,
        this.userImage,
        this.jobsType,
        this.resume});

  AppiledList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    totalExperienceYear = json['total_experience_year'];
    qualification = json['qualification'];
    expectedSalary = json['expected_salary'];
    city = json['city'];
    userImage = json['user_image'];
    jobsType = json['jobs_type'];
    resume = json['resume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['total_experience_year'] = this.totalExperienceYear;
    data['qualification'] = this.qualification;
    data['expected_salary'] = this.expectedSalary;
    data['city'] = this.city;
    data['user_image'] = this.userImage;
    data['jobs_type'] = this.jobsType;
    data['resume'] = this.resume;
    return data;
  }
}
