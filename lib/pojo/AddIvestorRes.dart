class AddIvestorRes {
  String? message;
  Result? result;
  //List<String>? error;


  AddIvestorRes({this.message, this.result});

  AddIvestorRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    //error = json['error'].cast<String>();
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? firstName;
  String? lastName;
  dynamic? corporateId;
  String? email;
  String? fullName;
  int? userTypeId;
  int? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Result(
      {this.firstName,
        this.lastName,
        this.corporateId,
        this.email,
        this.fullName,
        this.userTypeId,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id});

  Result.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    corporateId = json['corporate_id'];
    email = json['email'];
    fullName = json['full_name'];
    userTypeId = json['user_type_id'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['corporate_id'] = this.corporateId;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['user_type_id'] = this.userTypeId;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
