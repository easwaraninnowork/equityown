class EditAmentiesRes {
  String? message;
  List<Amenities>? amenities;
  List<NearByAmenities>? nearByAmenities;

  EditAmentiesRes({this.message, this.amenities, this.nearByAmenities});

  EditAmentiesRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(new Amenities.fromJson(v));
      });
    }
    if (json['near_by_amenities'] != null) {
      nearByAmenities = <NearByAmenities>[];
      json['near_by_amenities'].forEach((v) {
        nearByAmenities!.add(new NearByAmenities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.amenities != null) {
      data['amenities'] = this.amenities!.map((v) => v.toJson()).toList();
    }
    if (this.nearByAmenities != null) {
      data['near_by_amenities'] =
          this.nearByAmenities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Amenities {
  String? propertyId;
  String? name;
  String? updatedAt;
  String? createdAt;
  int? id;

  Amenities(
      {this.propertyId, this.name, this.updatedAt, this.createdAt, this.id});

  Amenities.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id'];
    name = json['name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property_id'] = this.propertyId;
    data['name'] = this.name;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class NearByAmenities {
  String? propertyId;
  String? description;
  String? updatedAt;
  String? createdAt;
  int? id;

  NearByAmenities(
      {this.propertyId,
        this.description,
        this.updatedAt,
        this.createdAt,
        this.id});

  NearByAmenities.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property_id'] = this.propertyId;
    data['description'] = this.description;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
