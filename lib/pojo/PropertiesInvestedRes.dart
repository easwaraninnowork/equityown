class PropertiesInvestedRes {
  Result? result;

  PropertiesInvestedRes({this.result});

  PropertiesInvestedRes.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic? nextPageUrl;
  String? path;
  int? perPage;
  dynamic? prevPageUrl;
  int? to;
  int? total;

  Result(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
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
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
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
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
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
  dynamic? profilePic;
  String? fullName;
  int? id;
  int? propertyId;
  String? propertyCode;
  String? projectName;
  String? location;
  String? deliveryDate;
  String? investedAmount;
  String? expectedRateOfReturn;
  String? investedDate;
  String? expectedReturn;
  String? paymentStatus;

  Data(
      {this.profilePic,
        this.fullName,
        this.id,
        this.propertyId,
        this.propertyCode,
        this.projectName,
        this.location,
        this.deliveryDate,
        this.investedAmount,
        this.expectedRateOfReturn,
        this.investedDate,
        this.expectedReturn,
        this.paymentStatus});

  Data.fromJson(Map<String, dynamic> json) {
    profilePic = json['profile_pic'];
    fullName = json['full_name'];
    id = json['id'];
    propertyId = json['property_id'];
    propertyCode = json['property_code'];
    projectName = json['project_name'];
    location = json['location'];
    deliveryDate = json['delivery_date'];
    investedAmount = json['invested_amount'];
    expectedRateOfReturn = json['expected_rate_of_return'];
    investedDate = json['invested_date'];
    expectedReturn = json['expected_return'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_pic'] = this.profilePic;
    data['full_name'] = this.fullName;
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['property_code'] = this.propertyCode;
    data['project_name'] = this.projectName;
    data['location'] = this.location;
    data['delivery_date'] = this.deliveryDate;
    data['invested_amount'] = this.investedAmount;
    data['expected_rate_of_return'] = this.expectedRateOfReturn;
    data['invested_date'] = this.investedDate;
    data['expected_return'] = this.expectedReturn;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
