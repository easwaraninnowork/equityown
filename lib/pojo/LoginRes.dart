class LoginRes {
  String? token;
  String? error;
  User? user;

  LoginRes({this.token, this.error, this.user});

  LoginRes.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    error = json['error'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['error'] = this.error;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? emailVerifiedAt;
  String? userType;
  int? status;
  String? mobilenumber;
  String? mobilenumberVerifiedAt;
  dynamic? secondaryEmail;
  dynamic? corporateId;
  int? userTypeId;
  dynamic? plainPswd;
  dynamic? profilePic;
  int? emailVerified;
  int? mobileVerified;
  dynamic? pwdVerifyToken;
  dynamic? emailVerifyToken;
  dynamic? emailVerifyTokenExpiresAt;
  dynamic? mobilenumberVerifyToken;
  dynamic? mobilenumberVerifyTokenExpiresAt;
  dynamic? dialCode;
  dynamic? gender;
  dynamic? countryCode;
  dynamic? ip;
  dynamic? passportId;
  dynamic? timezone;
  dynamic? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic? deletedAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.fullName,
        this.email,
        this.emailVerifiedAt,
        this.userType,
        this.status,
        this.mobilenumber,
        this.mobilenumberVerifiedAt,
        this.secondaryEmail,
        this.corporateId,
        this.userTypeId,
        this.plainPswd,
        this.profilePic,
        this.emailVerified,
        this.mobileVerified,
        this.pwdVerifyToken,
        this.emailVerifyToken,
        this.emailVerifyTokenExpiresAt,
        this.mobilenumberVerifyToken,
        this.mobilenumberVerifyTokenExpiresAt,
        this.dialCode,
        this.gender,
        this.countryCode,
        this.ip,
        this.passportId,
        this.timezone,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    userType = json['userType'];
    status = json['status'];
    mobilenumber = json['mobilenumber'];
    mobilenumberVerifiedAt = json['mobilenumber_verified_at'];
    secondaryEmail = json['secondary_email'];
    corporateId = json['corporate_id'];
    userTypeId = json['user_type_id'];
    plainPswd = json['plain_pswd'];
    profilePic = json['profile_pic'];
    emailVerified = json['email_verified'];
    mobileVerified = json['mobile_verified'];
    pwdVerifyToken = json['pwd_verify_token'];
    emailVerifyToken = json['email_verify_token'];
    emailVerifyTokenExpiresAt = json['email_verify_token_expires_at'];
    mobilenumberVerifyToken = json['mobilenumber_verify_token'];
    mobilenumberVerifyTokenExpiresAt =
    json['mobilenumber_verify_token_expires_at'];
    dialCode = json['dial_code'];
    gender = json['gender'];
    countryCode = json['country_code'];
    ip = json['ip'];
    passportId = json['passport_id'];
    timezone = json['timezone'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['userType'] = this.userType;
    data['status'] = this.status;
    data['mobilenumber'] = this.mobilenumber;
    data['mobilenumber_verified_at'] = this.mobilenumberVerifiedAt;
    data['secondary_email'] = this.secondaryEmail;
    data['corporate_id'] = this.corporateId;
    data['user_type_id'] = this.userTypeId;
    data['plain_pswd'] = this.plainPswd;
    data['profile_pic'] = this.profilePic;
    data['email_verified'] = this.emailVerified;
    data['mobile_verified'] = this.mobileVerified;
    data['pwd_verify_token'] = this.pwdVerifyToken;
    data['email_verify_token'] = this.emailVerifyToken;
    data['email_verify_token_expires_at'] = this.emailVerifyTokenExpiresAt;
    data['mobilenumber_verify_token'] = this.mobilenumberVerifyToken;
    data['mobilenumber_verify_token_expires_at'] =
        this.mobilenumberVerifyTokenExpiresAt;
    data['dial_code'] = this.dialCode;
    data['gender'] = this.gender;
    data['country_code'] = this.countryCode;
    data['ip'] = this.ip;
    data['passport_id'] = this.passportId;
    data['timezone'] = this.timezone;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
