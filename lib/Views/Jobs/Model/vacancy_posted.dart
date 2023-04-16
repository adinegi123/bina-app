class vaccancyPostedModel {
  List<Data>? data;
  String? message;
  bool? status;

  vaccancyPostedModel({this.data, this.message, this.status});

  vaccancyPostedModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? jobTitle;
  String? location;
  String? salaryRange;
  String? jobDescription;
  String? rolesResponsibility;
  String? jobsType;

  Data(
      {this.id,
        this.jobTitle,
        this.location,
        this.salaryRange,
        this.jobDescription,
        this.rolesResponsibility,
        this.jobsType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobTitle = json['job_title'];
    location = json['location'];
    salaryRange = json['salary_range'];
    jobDescription = json['job_description'];
    rolesResponsibility = json['roles_responsibility'];
    jobsType = json['jobs_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_title'] = this.jobTitle;
    data['location'] = this.location;
    data['salary_range'] = this.salaryRange;
    data['job_description'] = this.jobDescription;
    data['roles_responsibility'] = this.rolesResponsibility;
    data['jobs_type'] = this.jobsType;
    return data;
  }
}
