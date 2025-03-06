class PropertyImageRes {
  List<Result>? result;
  List<Images>? images;

  PropertyImageRes({this.result, this.images});

  PropertyImageRes.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? path;
  String? imageName;

  Result({this.id, this.path, this.imageName});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    imageName = json['image_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['image_name'] = this.imageName;
    return data;
  }
}

class Images {
  int? id;
  int? propertyId;
  String? imageName;
  String? createdAt;
  String? updatedAt;
  dynamic? deletedAt;

  Images(
      {this.id,
        this.propertyId,
        this.imageName,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    imageName = json['image_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['image_name'] = this.imageName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
