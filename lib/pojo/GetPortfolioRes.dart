class GetPortfolioRes {
  Result? result;
  int? totalInvestment;
  dynamic? totalGain;

  GetPortfolioRes({this.result, this.totalInvestment, this.totalGain});

  GetPortfolioRes.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
    totalInvestment = json['total_investment'];
    totalGain = json['total_gain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['total_investment'] = this.totalInvestment;
    data['total_gain'] = this.totalGain;
    return data;
  }
}

class Result {
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

  Result(
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

  Result.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? propertyId;
  String? projectName;
  String? location;
  String? deliveryDate;
  String? investedAmount;
  String? expectedRateOfReturn;
  String? expectedReturn;
  String? paymentStatus;

  Data(
      {this.id,
        this.propertyId,
        this.projectName,
        this.location,
        this.deliveryDate,
        this.investedAmount,
        this.expectedRateOfReturn,
        this.expectedReturn,
        this.paymentStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    projectName = json['project_name'];
    location = json['location'];
    deliveryDate = json['delivery_date'];
    investedAmount = json['invested_amount'];
    expectedRateOfReturn = json['expected_rate_of_return'];
    expectedReturn = json['expected_return'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['project_name'] = this.projectName;
    data['location'] = this.location;
    data['delivery_date'] = this.deliveryDate;
    data['invested_amount'] = this.investedAmount;
    data['expected_rate_of_return'] = this.expectedRateOfReturn;
    data['expected_return'] = this.expectedReturn;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}
