class EditAmentiesListResponse {
  Result? result;

  EditAmentiesListResponse({this.result});

  EditAmentiesListResponse.fromJson(Map<String, dynamic> json) {
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
  List<Amenities>? amenities;
  List<AmenitiesNearBy>? amenitiesNearBy;

  Result({this.amenities, this.amenitiesNearBy});

  Result.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amenities != null) {
      data['amenities'] = this.amenities!.map((v) => v.toJson()).toList();
    }
    if (this.amenitiesNearBy != null) {
      data['amenities_near_by'] =
          this.amenitiesNearBy!.map((v) => v.toJson()).toList();
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
  dynamic deletedAt;

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
  dynamic deletedAt;

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
