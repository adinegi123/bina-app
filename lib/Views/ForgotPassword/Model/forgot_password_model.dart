class forgotPassswordModel {
  String? status;
  String? message;
  List<UserList>? userList;
  String? result;

  forgotPassswordModel({this.status, this.message, this.userList, this.result});

  forgotPassswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['user_list'] != null) {
      userList = <UserList>[];
      json['user_list'].forEach((v) {
        userList!.add(new UserList.fromJson(v));
      });
    }
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userList != null) {
      data['user_list'] = this.userList!.map((v) => v.toJson()).toList();
    }
    data['result'] = this.result;
    return data;
  }
}

class UserList {
  String? userId;
  String? type;
  String? name;
  String? mobile;
  String? email;
  String? shortBio;
  String? userImage;
  String? password;

  UserList(
      {this.userId,
        this.type,
        this.name,
        this.mobile,
        this.email,
        this.shortBio,
        this.userImage,
        this.password});

  UserList.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    type = json['type'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    shortBio = json['short_bio'];
    userImage = json['user_image'];
    password = json['password'];
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
    data['password'] = this.password;
    return data;
  }
}
