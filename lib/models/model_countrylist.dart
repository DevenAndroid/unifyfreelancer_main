class ModelCountryList {
  bool? status;
  String? message;
  List<Data>? countryListData;

  ModelCountryList({this.status, this.message, this.countryListData});

  ModelCountryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      countryListData = <Data>[];
      json['data'].forEach((v) {
        countryListData!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.countryListData != null) {
      data['data'] = this.countryListData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? countryCode;

  Data({this.id, this.name, this.countryCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    return data;
  }
}
