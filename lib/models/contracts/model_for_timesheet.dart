class ModelTimesheet {
  bool? status;
  String? message;
  Data? data;

  ModelTimesheet({this.status, this.message, this.data});

  ModelTimesheet.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? yesterday;
  String? thisWeek;
  String? lastWeek;
  String? sinceStart;
  int? weekelyLimit;
  List<All>? all;

  Data(
      {this.yesterday,
        this.thisWeek,
        this.lastWeek,
        this.sinceStart,
        this.weekelyLimit,
        this.all});

  Data.fromJson(Map<String, dynamic> json) {
    yesterday = json['yesterday'];
    thisWeek = json['this_week'];
    lastWeek = json['last_week'];
    sinceStart = json['since_start'];
    weekelyLimit = json['weekelyLimit'];
    if (json['all'] != null) {
      all = <All>[];
      json['all'].forEach((v) {
        all!.add(new All.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yesterday'] = this.yesterday;
    data['this_week'] = this.thisWeek;
    data['last_week'] = this.lastWeek;
    data['since_start'] = this.sinceStart;
    data['weekelyLimit'] = this.weekelyLimit;
    if (this.all != null) {
      data['all'] = this.all!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class All {
  dynamic id;
  dynamic freelancerId;
  dynamic contractId;
  dynamic date;
  dynamic hours;
  dynamic save = false;
  dynamic newValue = "";

  All({this.id, this.freelancerId, this.contractId, this.date, this.hours});

  All.fromJson(Map<String, dynamic> json) {
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
