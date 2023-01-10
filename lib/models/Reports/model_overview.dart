class ModelOverview {
  bool? status;
  String? message;
  Data? data;

  ModelOverview({this.status, this.message, this.data});

  ModelOverview.fromJson(Map<String, dynamic> json) {
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
  WorkInProgress? workInProgress;
  List<Fixed>? inReview;
  List<Fixed>? pending;
  List<Fixed>? available;

  Data({this.workInProgress, this.inReview, this.pending, this.available});

  Data.fromJson(Map<String, dynamic> json) {
    workInProgress = json['work_in_progress'] != null
        ? new WorkInProgress.fromJson(json['work_in_progress'])
        : null;
    if (json['in_review'] != null) {
      inReview = <Fixed>[];
      json['in_review'].forEach((v) {
        inReview!.add(new Fixed.fromJson(v));
      });
    }
    if (json['pending'] != null) {
      pending = <Fixed>[];
      json['pending'].forEach((v) {
        pending!.add(new Fixed.fromJson(v));
      });
    }
    if (json['available'] != null) {
      available = <Fixed>[];
      json['available'].forEach((v) {
        available!.add(new Fixed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workInProgress != null) {
      data['work_in_progress'] = this.workInProgress!.toJson();
    }
    if (this.inReview != null) {
      data['in_review'] = this.inReview!.map((v) => v.toJson()).toList();
    }
    if (this.pending != null) {
      data['pending'] = this.pending!.map((v) => v.toJson()).toList();
    }
    if (this.available != null) {
      data['available'] = this.available!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkInProgress {
  List<Hourly>? hourly;
  List<Fixed>? fixed;

  WorkInProgress({this.hourly, this.fixed});

  WorkInProgress.fromJson(Map<String, dynamic> json) {
    if (json['hourly'] != null) {
      hourly = <Hourly>[];
      json['hourly'].forEach((v) {
        hourly!.add(new Hourly.fromJson(v));
      });
    }
    if (json['fixed'] != null) {
      fixed = <Fixed>[];
      json['fixed'].forEach((v) {
        fixed!.add(new Fixed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hourly != null) {
      data['hourly'] = this.hourly!.map((v) => v.toJson()).toList();
    }
    if (this.fixed != null) {
      data['fixed'] = this.fixed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hourly {
  dynamic freelancerId;
  dynamic clientId;
  dynamic projectId;
  dynamic amount;
  dynamic projectName;
  dynamic clientName;
  dynamic hours;
  dynamic date;

  Hourly(
      {this.freelancerId,
        this.clientId,
        this.projectId,
        this.amount,
        this.projectName,
        this.clientName,
        this.hours,
        this.date});

  Hourly.fromJson(Map<String, dynamic> json) {
    freelancerId = json['freelancer_id'];
    clientId = json['client_id'];
    projectId = json['project_id'];
    amount = json['amount'];
    projectName = json['project_name'];
    clientName = json['client_name'];
    hours = json['hours'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['freelancer_id'] = this.freelancerId;
    data['client_id'] = this.clientId;
    data['project_id'] = this.projectId;
    data['amount'] = this.amount;
    data['project_name'] = this.projectName;
    data['client_name'] = this.clientName;
    data['hours'] = this.hours;
    data['date'] = this.date;
    return data;
  }
}

class Fixed {
  dynamic dueDate;
  dynamic amount;
  dynamic clientName;
  dynamic projectName;

  Fixed({this.dueDate, this.amount, this.clientName, this.projectName});

  Fixed.fromJson(Map<String, dynamic> json) {
    dueDate = json['due_date'];
    amount = json['amount'];
    clientName = json['client_name'];
    projectName = json['project_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['due_date'] = this.dueDate;
    data['amount'] = this.amount;
    data['client_name'] = this.clientName;
    data['project_name'] = this.projectName;
    return data;
  }
}
