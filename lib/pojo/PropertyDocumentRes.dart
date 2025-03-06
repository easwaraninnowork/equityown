class PropertyDocumentRes {
  List<Result>? result;
  List<Documents>? documents;

  PropertyDocumentRes({this.result, this.documents});

  PropertyDocumentRes.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? path;
  String? documentName;

  Result({this.id, this.path, this.documentName});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    documentName = json['document_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['document_name'] = this.documentName;
    return data;
  }
}

class Documents {
  int? id;
  int? propertyId;
  String? name;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Documents(
      {this.id,
        this.propertyId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Documents.fromJson(Map<String, dynamic> json) {
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
