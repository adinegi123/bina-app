class loginresponseModelClass {
  bool? status;
  String? message;
  String? result;
  List<Data>? data;

  loginresponseModelClass({this.status, this.message, this.result, this.data});

  loginresponseModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? type;
  String? code;
  String? name;
  String? mobile;
  String? email;
  String? password;
  String? aadhar;
  String? dob;
  String? sex;
  String? age;
  String? website;
  String? sinceYear;
  String? shortBio;
  String? fees;
  String? race;
  String? relStatus;
  String? hobbies;
  String? lookingFor;
  String? address;
  String? country;
  String? state;
  String? city;
  String? education;
  String? userImage;
  String? document;
  String? bankName;
  String? branchName;
  String? ifscCode;
  String? swiftCode;
  String? accountNo;
  String? accountHolderName;
  String? paymentEmail;
  String? shippingTime;
  String? gumastaNo;
  String? fssaiNo;
  String? gstNo;
  String? gumastaImage;
  String? fssaiImage;
  String? gstImage;
  String? commissionBase;
  String? underCommission;
  String? overCommission;
  String? status;
  String? socialId;
  String? socialType;
  String? registerId;
  String? iosRegisterId;
  String? emailVerified;
  String? mobileVerified;
  String? otp;
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? membershipId;
  String? work;
  String? lat;
  String? lon;
  String? signupAs;
  String? expiryDate;
  String? termsCondition;
  String? entrydt;

  Data(
      {this.userId,
        this.type,
        this.code,
        this.name,
        this.mobile,
        this.email,
        this.password,
        this.aadhar,
        this.dob,
        this.sex,
        this.age,
        this.website,
        this.sinceYear,
        this.shortBio,
        this.fees,
        this.race,
        this.relStatus,
        this.hobbies,
        this.lookingFor,
        this.address,
        this.country,
        this.state,
        this.city,
        this.education,
        this.userImage,
        this.document,
        this.bankName,
        this.branchName,
        this.ifscCode,
        this.swiftCode,
        this.accountNo,
        this.accountHolderName,
        this.paymentEmail,
        this.shippingTime,
        this.gumastaNo,
        this.fssaiNo,
        this.gstNo,
        this.gumastaImage,
        this.fssaiImage,
        this.gstImage,
        this.commissionBase,
        this.underCommission,
        this.overCommission,
        this.status,
        this.socialId,
        this.socialType,
        this.registerId,
        this.iosRegisterId,
        this.emailVerified,
        this.mobileVerified,
        this.otp,
        this.categoryId,
        this.categoryName,
        this.subCategoryId,
        this.membershipId,
        this.work,
        this.lat,
        this.lon,
        this.signupAs,
        this.expiryDate,
        this.termsCondition,
        this.entrydt});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    type = json['type'];
    code = json['code'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    aadhar = json['aadhar'];
    dob = json['dob'];
    sex = json['sex'];
    age = json['age'];
    website = json['website'];
    sinceYear = json['since_year'];
    shortBio = json['short_bio'];
    fees = json['fees'];
    race = json['race'];
    relStatus = json['rel_status'];
    hobbies = json['hobbies'];
    lookingFor = json['looking_for'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    education = json['education'];
    userImage = json['user_image'];
    document = json['document'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    ifscCode = json['ifsc_code'];
    swiftCode = json['swift_code'];
    accountNo = json['account_no'];
    accountHolderName = json['account_holder_name'];
    paymentEmail = json['payment_email'];
    shippingTime = json['shipping_time'];
    gumastaNo = json['gumasta_no'];
    fssaiNo = json['fssai_no'];
    gstNo = json['gst_no'];
    gumastaImage = json['gumasta_image'];
    fssaiImage = json['fssai_image'];
    gstImage = json['gst_image'];
    commissionBase = json['commission_base'];
    underCommission = json['under_commission'];
    overCommission = json['over_commission'];
    status = json['status'];
    socialId = json['social_id'];
    socialType = json['social_type'];
    registerId = json['register_id'];
    iosRegisterId = json['ios_register_id'];
    emailVerified = json['email_verified'];
    mobileVerified = json['mobile_verified'];
    otp = json['otp'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subCategoryId = json['sub_category_id'];
    membershipId = json['membership_id'];
    work = json['work'];
    lat = json['lat'];
    lon = json['lon'];
    signupAs = json['signup_as'];
    expiryDate = json['expiry_date'];
    termsCondition = json['terms_condition'];
    entrydt = json['entrydt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['code'] = this.code;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['aadhar'] = this.aadhar;
    data['dob'] = this.dob;
    data['sex'] = this.sex;
    data['age'] = this.age;
    data['website'] = this.website;
    data['since_year'] = this.sinceYear;
    data['short_bio'] = this.shortBio;
    data['fees'] = this.fees;
    data['race'] = this.race;
    data['rel_status'] = this.relStatus;
    data['hobbies'] = this.hobbies;
    data['looking_for'] = this.lookingFor;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['education'] = this.education;
    data['user_image'] = this.userImage;
    data['document'] = this.document;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['ifsc_code'] = this.ifscCode;
    data['swift_code'] = this.swiftCode;
    data['account_no'] = this.accountNo;
    data['account_holder_name'] = this.accountHolderName;
    data['payment_email'] = this.paymentEmail;
    data['shipping_time'] = this.shippingTime;
    data['gumasta_no'] = this.gumastaNo;
    data['fssai_no'] = this.fssaiNo;
    data['gst_no'] = this.gstNo;
    data['gumasta_image'] = this.gumastaImage;
    data['fssai_image'] = this.fssaiImage;
    data['gst_image'] = this.gstImage;
    data['commission_base'] = this.commissionBase;
    data['under_commission'] = this.underCommission;
    data['over_commission'] = this.overCommission;
    data['status'] = this.status;
    data['social_id'] = this.socialId;
    data['social_type'] = this.socialType;
    data['register_id'] = this.registerId;
    data['ios_register_id'] = this.iosRegisterId;
    data['email_verified'] = this.emailVerified;
    data['mobile_verified'] = this.mobileVerified;
    data['otp'] = this.otp;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['sub_category_id'] = this.subCategoryId;
    data['membership_id'] = this.membershipId;
    data['work'] = this.work;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['signup_as'] = this.signupAs;
    data['expiry_date'] = this.expiryDate;
    data['terms_condition'] = this.termsCondition;
    data['entrydt'] = this.entrydt;
    return data;
  }
}
