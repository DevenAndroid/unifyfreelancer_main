import 'package:get/get.dart';

class ModelSkillListResponse {
  bool? status;
  String? message;
  List<AllData>? data;

  ModelSkillListResponse({this.status, this.message, this.data});

  ModelSkillListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllData>[];
      json['data'].forEach((v) {
        data!.add(new AllData.fromJson(v));
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

class AllData {
  int? id;
  String? name;
  RxBool? isSelected = false.obs;

  AllData({this.id, this.name,this.isSelected});

  AllData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
