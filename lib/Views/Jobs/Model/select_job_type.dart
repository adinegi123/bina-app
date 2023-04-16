class jobTypeListModelClass {
  List<JobTypeList>? jobTypeList;
  bool? status;

  jobTypeListModelClass({this.jobTypeList, this.status});

  jobTypeListModelClass.fromJson(Map<String, dynamic> json) {
    if (json['job_type_list'] != null) {
      jobTypeList = <JobTypeList>[];
      json['job_type_list'].forEach((v) {
        jobTypeList!.add(new JobTypeList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobTypeList != null) {
      data['job_type_list'] = this.jobTypeList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class JobTypeList {
  String? id;
  String? jobsType;

  JobTypeList({this.id, this.jobsType});

  JobTypeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobsType = json['jobs_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobs_type'] = this.jobsType;
    return data;
  }
}
