
class UserPropertiesRes {
  Result? result;

  UserPropertiesRes({this.result});

  UserPropertiesRes.fromJson(Map<String, dynamic> json) {
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
  String? nextPageUrl;
  String? path;
  dynamic perPage;
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
  String? name;
  String? code;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? latitude;
  String? longitude;
  String? overview;
  String? projectDetails;
  String? status;
  int? value;
  dynamic projectedGrossYield;
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
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? stateId;
  String? fundedPercentage;
  int? numberOfInvestors;
  int? isInvested;
  List<Amenities>? amenities;
  List<AmenitiesNearBy>? amenitiesNearBy;
  List<Images>? images;
  List<Documents>? documents;
  List<Milestones>? milestones;
  List<FundingLog>? fundingLog;

  Data(
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
        this.deletedAt,
        this.stateId,
        this.fundedPercentage,
        this.numberOfInvestors,
        this.isInvested,
        this.amenities,
        this.amenitiesNearBy,
        this.images,
        this.documents,
        this.milestones,
        this.fundingLog});

  Data.fromJson(Map<String, dynamic> json) {
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
    stateId = json['state_id'];
    fundedPercentage = json['funded_percentage'];
    numberOfInvestors = json['number_of_investors'];
    isInvested = json['is_invested'];
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(new Amenities.fromJson(v));
      });
    }
    if (json['amenities_near_by'] != null) {
      amenitiesNearBy = <AmenitiesNearBy>[];
      json['amenities_near_by'].forEach((v) {
        amenitiesNearBy!.add(new AmenitiesNearBy.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
    if (json['milestones'] != null) {
      milestones = <Milestones>[];
      json['milestones'].forEach((v) {
        milestones!.add(new Milestones.fromJson(v));
      });
    }
    if (json['funding_log'] != null) {
      fundingLog = <FundingLog>[];
      json['funding_log'].forEach((v) {
        fundingLog!.add(new FundingLog.fromJson(v));
      });
    }
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
    data['state_id'] = this.stateId;
    data['funded_percentage'] = this.fundedPercentage;
    data['number_of_investors'] = this.numberOfInvestors;
    data['is_invested'] = this.isInvested;
    if (this.amenities != null) {
      data['amenities'] = this.amenities!.map((v) => v.toJson()).toList();
    }
    if (this.amenitiesNearBy != null) {
      data['amenities_near_by'] =
          this.amenitiesNearBy!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    if (this.milestones != null) {
      data['milestones'] = this.milestones!.map((v) => v.toJson()).toList();
    }
    if (this.fundingLog != null) {
      data['funding_log'] = this.fundingLog!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Amenities {
  int? id;
  int? propertyId;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Amenities(
      {this.id,
        this.propertyId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Amenities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class AmenitiesNearBy {
  int? id;
  int? propertyId;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  AmenitiesNearBy(
      {this.id,
        this.propertyId,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  AmenitiesNearBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Images {
  int? id;
  int? propertyId;
  String? imageName;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? path;

  Images(
      {this.id,
        this.propertyId,
        this.imageName,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.path});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    imageName = json['image_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['image_name'] = this.imageName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['path'] = this.path;
    return data;
  }
}

class Documents {
  int? id;
  int? propertyId;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? path;
  String? documentName;

  Documents(
      {this.id,
        this.propertyId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.path,
        this.documentName});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    path = json['path'];
    documentName = json['document_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['path'] = this.path;
    data['document_name'] = this.documentName;
    return data;
  }
}

class Milestones {
  int? id;
  int? propertyId;
  int? createdBy;
  String? date;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Milestones(
      {this.id,
        this.propertyId,
        this.createdBy,
        this.date,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Milestones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    createdBy = json['created_by'];
    date = json['date'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['created_by'] = this.createdBy;
    data['date'] = this.date;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class FundingLog {
  int? id;
  int? propertyId;
  int? createdBy;
  String? date;
  String? description;
  String? createdAt;
  String? updatedAt;
  dynamic? deletedAt;

  FundingLog(
      {this.id,
        this.propertyId,
        this.createdBy,
        this.date,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  FundingLog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    createdBy = json['created_by'];
    date = json['date'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['created_by'] = this.createdBy;
    data['date'] = this.date;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
