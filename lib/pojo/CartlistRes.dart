class CartlistRes {
  List<Result>? result;

  CartlistRes({this.result});

  CartlistRes.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? cartId;
  String? propertyName;
  String? code;
  String? address;
  String? city;
  String? state;
  int? id;
  int? propertyId;
  int? userId;
  int? wishlistId;
  String? investment;
  String? status;
  String? expectedRateOfReturn;
  String? expectedReturn;
  String? expectedClosingDate;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? investorName;
  String? profilePicPath;
  bool? selectedBool;

  Result(
      {this.cartId,
        this.propertyName,
        this.code,
        this.address,
        this.city,
        this.state,
        this.id,
        this.propertyId,
        this.userId,
        this.wishlistId,
        this.investment,
        this.status,
        this.expectedRateOfReturn,
        this.expectedReturn,
        this.expectedClosingDate,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.investorName,
        this.profilePicPath,
        this.selectedBool});

  Result.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    propertyName = json['property_name'];
    code = json['code'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    id = json['id'];
    propertyId = json['property_id'];
    userId = json['user_id'];
    wishlistId = json['wishlist_id'];
    investment = json['investment'];
    status = json['status'];
    expectedRateOfReturn = json['expected_rate_of_return'];
    expectedReturn = json['expected_return'];
    expectedClosingDate = json['expected_closing_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    investorName = json['investor_name'];
    profilePicPath = json['profile_pic_path'];
    selectedBool = json['selected_bool'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['property_name'] = this.propertyName;
    data['code'] = this.code;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['user_id'] = this.userId;
    data['wishlist_id'] = this.wishlistId;
    data['investment'] = this.investment;
    data['status'] = this.status;
    data['expected_rate_of_return'] = this.expectedRateOfReturn;
    data['expected_return'] = this.expectedReturn;
    data['expected_closing_date'] = this.expectedClosingDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['investor_name'] = this.investorName;
    data['profile_pic_path'] = this.profilePicPath;
    data['selected_bool'] = this.selectedBool;
    return data;
  }
}
