class appliedcandidatesCountModelClass {
  int? countAppiliedCadidates;
  bool? status;

  appliedcandidatesCountModelClass({this.countAppiliedCadidates, this.status});

  appliedcandidatesCountModelClass.fromJson(Map<String, dynamic> json) {
    countAppiliedCadidates = json['count_appilied_cadidates'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count_appilied_cadidates'] = this.countAppiliedCadidates;
    data['status'] = this.status;
    return data;
  }
}
