class ModelCountryList {
  List<Countrylist>? countrylist;
  bool? status;
  String? message;

  ModelCountryList({this.countrylist, this.status, this.message});

  ModelCountryList.fromJson(Map<String, dynamic> json) {
    if (json['countrylist'] != null) {
      countrylist = <Countrylist>[];
      json['countrylist'].forEach((v) {
        countrylist!.add(new Countrylist.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countrylist != null) {
      data['countrylist'] = this.countrylist!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Countrylist {
  String? name;

  Countrylist({this.name});

  Countrylist.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
