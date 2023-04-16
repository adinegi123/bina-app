class vaccancyListModelClass {
  List<TotalVacancy>? totalVacancy;
  bool? status;

  vaccancyListModelClass({this.totalVacancy, this.status});

  vaccancyListModelClass.fromJson(Map<String, dynamic> json) {
    if (json['total_vacancy'] != null) {
      totalVacancy = <TotalVacancy>[];
      json['total_vacancy'].forEach((v) {
        totalVacancy!.add(new TotalVacancy.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.totalVacancy != null) {
      data['total_vacancy'] =
          this.totalVacancy!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class TotalVacancy {
  String? id;
  String? userId;
  String? jobTitle;
  String? location;
  String? jobsType;
  String? minimumExperienceYear;
  String? minimumExperienceMonth;
  String? salaryRange;
  String? jobDescription;
  String? rolesResponsibility;
  String? createdAt;
  String? updatedAt;
  String? userImage;

  TotalVacancy(
      {this.id,
        this.userId,
        this.jobTitle,
        this.location,
        this.jobsType,
        this.minimumExperienceYear,
        this.minimumExperienceMonth,
        this.salaryRange,
        this.jobDescription,
        this.rolesResponsibility,
        this.createdAt,
        this.updatedAt,
        this.userImage});

  TotalVacancy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    jobTitle = json['job_title'];
    location = json['location'];
    jobsType = json['jobs_type'];
    minimumExperienceYear = json['minimum_experience_year'];
    minimumExperienceMonth = json['minimum_experience_month'];
    salaryRange = json['salary_range'];
    jobDescription = json['job_description'];
    rolesResponsibility = json['roles_responsibility'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['job_title'] = this.jobTitle;
    data['location'] = this.location;
    data['jobs_type'] = this.jobsType;
    data['minimum_experience_year'] = this.minimumExperienceYear;
    data['minimum_experience_month'] = this.minimumExperienceMonth;
    data['salary_range'] = this.salaryRange;
    data['job_description'] = this.jobDescription;
    data['roles_responsibility'] = this.rolesResponsibility;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_image'] = this.userImage;
    return data;
  }
}
