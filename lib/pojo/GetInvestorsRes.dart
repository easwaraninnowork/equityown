class GetInvestorsRes {
  Investors? investors;

  GetInvestorsRes({this.investors});

  GetInvestorsRes.fromJson(Map<String, dynamic> json) {
    investors = json['investors'] != null
        ? new Investors.fromJson(json['investors'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.investors != null) {
      data['investors'] = this.investors!.toJson();
    }
    return data;
  }
}

class Investors {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  dynamic? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Investors(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Investors.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? userId;
  String? fullName;
  String? email;
  String? mobilenumber;
  int? mobileVerified;
  int? emailVerified;
  String? profilePicPath;
  String? mobileVerifiedStatus;
  String? emailVerifiedStatus;

  Data(
      {this.userId,
        this.fullName,
        this.email,
        this.mobilenumber,
        this.mobileVerified,
        this.emailVerified,
        this.profilePicPath,
        this.mobileVerifiedStatus,
        this.emailVerifiedStatus});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    email = json['email'];
    mobilenumber = json['mobilenumber'];
    mobileVerified = json['mobile_verified'];
    emailVerified = json['email_verified'];
    profilePicPath = json['profile_pic_path'];
    mobileVerifiedStatus = json['mobile_verified_status'];
    emailVerifiedStatus = json['email_verified_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['mobilenumber'] = this.mobilenumber;
    data['mobile_verified'] = this.mobileVerified;
    data['email_verified'] = this.emailVerified;
    data['profile_pic_path'] = this.profilePicPath;
    data['mobile_verified_status'] = this.mobileVerifiedStatus;
    data['email_verified_status'] = this.emailVerifiedStatus;
    return data;
  }
}
