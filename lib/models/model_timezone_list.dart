class ModelTimeZone {
  bool? status;
  String? message;
  List<Data>? data;

  ModelTimeZone({this.status, this.message, this.data});

  ModelTimeZone.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? countryCode;
  String? timezone;

  Data({this.countryCode, this.timezone});

  Data.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['timezone'] = this.timezone;
    return data;
  }
}
