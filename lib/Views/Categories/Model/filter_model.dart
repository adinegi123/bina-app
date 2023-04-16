class filterapimodelclass {
  List<Result>? result;
  String? message;
  bool? status;

  filterapimodelclass({this.result, this.message, this.status});

  filterapimodelclass.fromJson(Map<String, dynamic> json) {
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
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Result {
  String? userId;
  String? type;
  String? name;
  String? mobile;
  String? email;
  String? shortBio;
  String? userImage;
  var averageRating;

  Result(
      {this.userId,
        this.type,
        this.name,
        this.mobile,
        this.email,
        this.shortBio,
        this.userImage,
        this.averageRating});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    type = json['type'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    shortBio = json['short_bio'];
    userImage = json['user_image'];
    averageRating = json['averageRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['short_bio'] = this.shortBio;
    data['user_image'] = this.userImage;
    data['averageRating'] = this.averageRating;
    return data;
  }
}
