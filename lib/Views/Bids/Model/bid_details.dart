class bidDetailsModel {
  BidList? bidList;
  bool? status;

  bidDetailsModel({this.bidList, this.status});

  bidDetailsModel.fromJson(Map<String, dynamic> json) {
    bidList = json['bid_list'] != null
        ? new BidList.fromJson(json['bid_list'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bidList != null) {
      data['bid_list'] = this.bidList!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class BidList {
  BidListData? bidList;
  int? countTotalBid;
  String? offerBidEndDate;

  BidList({this.bidList, this.countTotalBid, this.offerBidEndDate});

  BidList.fromJson(Map<String, dynamic> json) {
    bidList = json['Bid_list'] != null
        ? new BidListData.fromJson(json['Bid_list'])
        : null;
    countTotalBid = json['countTotalBid'];
    offerBidEndDate = json['offerBidEndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bidList != null) {
      data['Bid_list'] = this.bidList!.toJson();
    }
    data['countTotalBid'] = this.countTotalBid;
    data['offerBidEndDate'] = this.offerBidEndDate;
    return data;
  }
}

class BidListData {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? image;
  String? file;
  String? scheduleDate;
  String? bidTill;
  String? bidTillDate;
  String? status;
  String? createdAt;
  String? updatedAt;

  BidListData(
      {this.id,
        this.userId,
        this.title,
        this.description,
        this.image,
        this.file,
        this.scheduleDate,
        this.bidTill,
        this.bidTillDate,
        this.status,
        this.createdAt,
        this.updatedAt});

  BidListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    file = json['file'];
    scheduleDate = json['schedule_date'];
    bidTill = json['bid_till'];
    bidTillDate = json['bid_till_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['file'] = this.file;
    data['schedule_date'] = this.scheduleDate;
    data['bid_till'] = this.bidTill;
    data['bid_till_date'] = this.bidTillDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
