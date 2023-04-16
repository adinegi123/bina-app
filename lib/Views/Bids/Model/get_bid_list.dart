class getBidListModelClass {
  List<BidList>? bidList;
  bool? status;

  getBidListModelClass({this.bidList, this.status});

  getBidListModelClass.fromJson(Map<String, dynamic> json) {
    if (json['bid_list'] != null) {
      bidList = <BidList>[];
      json['bid_list'].forEach((v) {
        bidList!.add(new BidList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bidList != null) {
      data['bid_list'] = this.bidList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class BidList {
  String? id;
  String? title;
  String? image;
  int? countList;
  String? endingIn;

  BidList({this.id, this.title, this.image, this.countList, this.endingIn});

  BidList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    countList = json['countList'];
    endingIn = json['endingIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['countList'] = this.countList;
    data['endingIn'] = this.endingIn;
    return data;
  }
}
