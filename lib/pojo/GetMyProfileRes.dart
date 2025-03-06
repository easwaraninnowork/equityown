class GetMyprofileRes {
  Result? result;

  GetMyprofileRes({this.result});

  GetMyprofileRes.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? userId;
  String? fullName;
  String? email;
  String? mobilenumber;
  int? mobileVerified;
  int? emailVerified;
  String? profilePicPath;
  String? mobileVerifiedStatus;
  String? emailVerifiedStatus;

  Result(
      {this.userId,
        this.fullName,
        this.email,
        this.mobilenumber,
        this.mobileVerified,
        this.emailVerified,
        this.profilePicPath,
        this.mobileVerifiedStatus,
        this.emailVerifiedStatus});

  Result.fromJson(Map<String, dynamic> json) {
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
