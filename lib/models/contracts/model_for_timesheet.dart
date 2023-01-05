class ModelTimesheet {
  bool? status;
  String? message;
  List<Data>? data;

  ModelTimesheet({this.status, this.message, this.data});

  ModelTimesheet.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic freelancerId;
  dynamic contractId;
  dynamic date;
  dynamic hours;
  dynamic newValue = "";
  dynamic save = false;

  Data({this.id, this.freelancerId, this.contractId, this.date, this.hours, this.newValue, this.save});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    freelancerId = json['freelancer_id'];
    contractId = json['contract_id'];
    date = json['date'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['freelancer_id'] = this.freelancerId;
    data['contract_id'] = this.contractId;
    data['date'] = this.date;
    data['hours'] = this.hours;
    return data;
  }
}
