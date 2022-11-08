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
  List<SubmittedProposal>? submittedProposal;
  List<SubmittedProposal>? activeProposal;
  List<SubmittedProposal>? interviewForInvitation;

  Data(
      {this.submittedProposal,
        this.activeProposal,
        this.interviewForInvitation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['submittedProposal'] != null) {
      submittedProposal = <SubmittedProposal>[];
      json['submittedProposal'].forEach((v) {
        submittedProposal!.add(new SubmittedProposal.fromJson(v));
      });
    }
    if (json['activeProposal'] != null) {
      activeProposal = <SubmittedProposal>[];
      json['activeProposal'].forEach((v) {
        activeProposal!.add(new SubmittedProposal.fromJson(v));
      });
    }
    if (json['interviewForInvitation'] != null) {
      interviewForInvitation = <SubmittedProposal>[];
      json['interviewForInvitation'].forEach((v) {
        interviewForInvitation!.add(new SubmittedProposal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class SubmittedProposal {
  String? projectId;
  String? proposalId;
  String? clientId;
  String? name;
  String? proposalDescription;
  String? projectDescription;
  String? status;
  String? time;

  SubmittedProposal(
      {this.projectId,
        this.proposalId,
        this.clientId,
        this.name,
        this.proposalDescription,
        this.projectDescription,
        this.status,
        this.time});

  SubmittedProposal.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    proposalId = json['proposal_id'];
    clientId = json['client_id'];
    name = json['name'];
    proposalDescription = json['proposal_description'];
    projectDescription = json['project_description'];
    status = json['status'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['proposal_id'] = this.proposalId;
    data['client_id'] = this.clientId;
    data['name'] = this.name;
    data['proposal_description'] = this.proposalDescription;
    data['project_description'] = this.projectDescription;
    data['status'] = this.status;
    data['time'] = this.time;
    return data;
  }
}
