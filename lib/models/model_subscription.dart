class ModelSubscriptionPlans {
  bool? status;
  String? message;
  List<Data>? data;

  ModelSubscriptionPlans({this.status, this.message, this.data});

  ModelSubscriptionPlans.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? title;
  String? validity;
  int? amount;
  String? description;
  List<Services>? services;

  Data(
      {this.id,
        this.title,
        this.validity,
        this.amount,
        this.description,
        this.services});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    validity = json['validity'];
    amount = json['amount'];
    description = json['description'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['validity'] = this.validity;
    data['amount'] = this.amount;
    data['description'] = this.description;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String? serviceName;
  String? description;

  Services({this.serviceName, this.description});

  Services.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_name'] = this.serviceName;
    data['description'] = this.description;
    return data;
  }
}
