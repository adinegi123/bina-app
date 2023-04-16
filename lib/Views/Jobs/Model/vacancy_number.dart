class vaccancynumberModelClass {
  int? totalVacancy;
  bool? status;

  vaccancynumberModelClass({this.totalVacancy, this.status});

  vaccancynumberModelClass.fromJson(Map<String, dynamic> json) {
    totalVacancy = json['total_vacancy'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_vacancy'] = this.totalVacancy;
    data['status'] = this.status;
    return data;
  }
}
