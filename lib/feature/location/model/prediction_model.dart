class PredictionModel {
  String? description;
  String? id;
  int? distanceMeters;
  String? placeId;
  Geometry? geometry;
  String? reference;

  PredictionModel(
      {this.description,
        this.id,
        this.distanceMeters,
        this.placeId,
        this.geometry,
        this.reference});

  PredictionModel.fromJson(Map<String, dynamic> json) {
    description = json['formatted_address'];
    id = json['id'];
    distanceMeters = json['distance_meters'];
    placeId = json['place_id'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formatted_address'] = description;
    data['id'] = id;
    data['distance_meters'] = distanceMeters;
    data['place_id'] = placeId;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    data['reference'] = reference;
    return data;
  }
}

class Geometry {
  Locations? locations;
  String? locationType;


  Geometry({this.locations, this.locationType});

  Geometry.fromJson(Map<String, dynamic> json) {
    locations = json['location'] != null
        ? new Locations.fromJson(json['location'])
        : null;
    locationType = json['location_type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.locations != null) {
      data['location'] = this.locations!.toJson();
    }
    data['location_type'] = this.locationType;

    return data;
  }
}

class Locations {
  dynamic lat;
  dynamic lng;

  Locations({this.lat, this.lng});

  Locations.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}