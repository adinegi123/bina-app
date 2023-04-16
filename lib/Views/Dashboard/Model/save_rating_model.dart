class saveRatingModel {
  Data? data;
  String? message;
  bool? status;

  saveRatingModel({this.data, this.message, this.status});

  saveRatingModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? rating;
  String? review;
  String? photos;

  Data({this.rating, this.review, this.photos});

  Data.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    review = json['review'];
    photos = json['photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['photos'] = this.photos;
    return data;
  }
}
