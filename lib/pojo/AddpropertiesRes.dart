class AddpropertiesRes {
  String? message;
  Result? result;

  AddpropertiesRes({this.message, this.result});

  AddpropertiesRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
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
  int? id;
  String? name;
  String? code;
  String? address;
  String? city;
  String? state;
  dynamic country;
  String? zipcode;
  String? latitude;
  String? longitude;
  String? overview;
  String? projectDetails;
  String? status;
  int? value;
  int? projectedGrossYield;
  int? tenure;
  String? startDate;
  String? deliveryDate;
  int? annualReturn;
  int? rateOfReturn;
  String? fundReturnDate;
  int? expectedTotalFundReturn;
  int? expectedGain;
  int? showInWebsite;
  int? createdBy;
  int? updatedBy;
  dynamic createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Result(
      {this.id,
        this.name,
        this.code,
        this.address,
        this.city,
        this.state,
        this.country,
        this.zipcode,
        this.latitude,
        this.longitude,
        this.overview,
        this.projectDetails,
        this.status,
        this.value,
        this.projectedGrossYield,
        this.tenure,
        this.startDate,
        this.deliveryDate,
        this.annualReturn,
        this.rateOfReturn,
        this.fundReturnDate,
        this.expectedTotalFundReturn,
        this.expectedGain,
        this.showInWebsite,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipcode = json['zipcode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    overview = json['overview'];
    projectDetails = json['project_details'];
    status = json['status'];
    value = json['value'];
    projectedGrossYield = json['projected_gross_yield'];
    tenure = json['tenure'];
    startDate = json['start_date'];
    deliveryDate = json['delivery_date'];
    annualReturn = json['annual_return'];
    rateOfReturn = json['rate_of_return'];
    fundReturnDate = json['fund_return_date'];
    expectedTotalFundReturn = json['expected_total_fund_return'];
    expectedGain = json['expected_gain'];
    showInWebsite = json['show_in_website'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zipcode'] = this.zipcode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['overview'] = this.overview;
    data['project_details'] = this.projectDetails;
    data['status'] = this.status;
    data['value'] = this.value;
    data['projected_gross_yield'] = this.projectedGrossYield;
    data['tenure'] = this.tenure;
    data['start_date'] = this.startDate;
    data['delivery_date'] = this.deliveryDate;
    data['annual_return'] = this.annualReturn;
    data['rate_of_return'] = this.rateOfReturn;
    data['fund_return_date'] = this.fundReturnDate;
    data['expected_total_fund_return'] = this.expectedTotalFundReturn;
    data['expected_gain'] = this.expectedGain;
    data['show_in_website'] = this.showInWebsite;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
