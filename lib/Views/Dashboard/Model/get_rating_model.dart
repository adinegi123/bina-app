class getratingModel {
  List<Data>? data;
  bool? status;

  getratingModel({this.data, this.status});

  getratingModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? userImage;
  String? entrydt;
  var rating;
  String? review;
  String? photos;

  Data(
      {this.name,
        this.userImage,
        this.entrydt,
        this.rating,
        this.review,
        this.photos});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userImage = json['user_image'];
    entrydt = json['entrydt'];
    rating = json['rating'];
    review = json['review'];
    photos = json['photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_image'] = this.userImage;
    data['entrydt'] = this.entrydt;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['photos'] = this.photos;
    return data;
  }
}
