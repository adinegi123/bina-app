class createBidModelClass {
  int? bidId;
  String? message;
  bool? status;

  createBidModelClass({this.bidId, this.message, this.status});

  createBidModelClass.fromJson(Map<String, dynamic> json) {
    bidId = json['bid_id'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bid_id'] = this.bidId;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
