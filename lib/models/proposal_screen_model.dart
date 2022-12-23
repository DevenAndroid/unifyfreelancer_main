class ModelProposal {
  bool? status;
  String? message;
  Data? data;

  ModelProposal({this.status, this.message, this.data});

  ModelProposal.fromJson(Map<String, dynamic> json) {
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
  List<Offers>? offers;
  List<Offers>? submittedProposal;
  List<Offers>? activeProposal;
  List<Offers>? interviewForInvitation;

  Data(
      {this.offers,
        this.submittedProposal,
        this.activeProposal,
        this.interviewForInvitation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
    if (json['submittedProposal'] != null) {
      submittedProposal = <Offers>[];
      json['submittedProposal'].forEach((v) {
        submittedProposal!.add(new Offers.fromJson(v));
      });
    }
    if (json['activeProposal'] != null) {
      activeProposal = <Offers>[];
      json['activeProposal'].forEach((v) {
        activeProposal!.add(new Offers.fromJson(v));
      });
    }
    if (json['interviewForInvitation'] != null) {
      interviewForInvitation = <Offers>[];
      json['interviewForInvitation'].forEach((v) {
        interviewForInvitation!.add(new Offers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    if (this.submittedProposal != null) {
      data['submittedProposal'] =
          this.submittedProposal!.map((v) => v.toJson()).toList();
    }
    if (this.activeProposal != null) {
      data['activeProposal'] =
          this.activeProposal!.map((v) => v.toJson()).toList();
    }
    if (this.interviewForInvitation != null) {
      data['interviewForInvitation'] =
          this.interviewForInvitation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offers {
  String? id;
  String? projectId;
  String? clientId;
  String? name;
  String? status;
  String? budgetType;
  String? date;
  String? time;

  Offers(
      {this.id,
        this.projectId,
        this.clientId,
        this.name,
        this.status,
        this.budgetType,
        this.date,
        this.time});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    clientId = json['client_id'];
    name = json['name'];
    status = json['status'];
    budgetType = json['budget_type'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['client_id'] = this.clientId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['budget_type'] = this.budgetType;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
