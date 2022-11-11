class ModelSingleJob {
  bool? status;
  String? message;
  Data? data;

  ModelSingleJob({this.status, this.message, this.data});

  ModelSingleJob.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic clientId;
  dynamic image;
  dynamic name;
  dynamic type;
  dynamic description;
  dynamic budgetType;
  dynamic minPrice;
  dynamic price;
  dynamic projectDuration;
  dynamic status;
  dynamic experienceLevel;
  dynamic categories;
  List<Skills>? skills;
  List<ProposalList>? proposalList;
  Null? clientData;

  Data(
      {this.id,
        this.clientId,
        this.image,
        this.name,
        this.type,
        this.description,
        this.budgetType,
        this.minPrice,
        this.price,
        this.projectDuration,
        this.status,
        this.experienceLevel,
        this.categories,
        this.skills,
        this.proposalList,
        this.clientData});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    image = json['image'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    budgetType = json['budget_type'];
    minPrice = json['min_price'];
    price = json['price'];
    projectDuration = json['project_duration'];
    status = json['status'];
    experienceLevel = json['experience_level'];
    categories = json['categories'];
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(new Skills.fromJson(v));
      });
    }
    if (json['proposal_list'] != null) {
      proposalList = <ProposalList>[];
      json['proposal_list'].forEach((v) {
        proposalList!.add(new ProposalList.fromJson(v));
      });
    }
    clientData = json['client_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['type'] = this.type;
    data['description'] = this.description;
    data['budget_type'] = this.budgetType;
    data['min_price'] = this.minPrice;
    data['price'] = this.price;
    data['project_duration'] = this.projectDuration;
    data['status'] = this.status;
    data['experience_level'] = this.experienceLevel;
    data['categories'] = this.categories;
    if (this.skills != null) {
      data['skills'] = this.skills!.map((v) => v.toJson()).toList();
    }
    if (this.proposalList != null) {
      data['proposal_list'] =
          this.proposalList!.map((v) => v.toJson()).toList();
    }
    data['client_data'] = this.clientData;
    return data;
  }
}

class Skills {
  String? id;
  String? name;

  Skills({this.id, this.name});

  Skills.fromJson(Map<String, dynamic> json) {
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

class ProposalList {
  String? freelancerId;
  String? freelancerName;
  String? profileImage;
  String? proposalId;
  String? proposalDescription;
  String? status;
  String? bidAmount;
  String? time;

  ProposalList(
      {this.freelancerId,
        this.freelancerName,
        this.profileImage,
        this.proposalId,
        this.proposalDescription,
        this.status,
        this.bidAmount,
        this.time});

  ProposalList.fromJson(Map<String, dynamic> json) {
    freelancerId = json['freelancer_id'];
    freelancerName = json['freelancer_name'];
    profileImage = json['profile_image'];
    proposalId = json['proposal_id'];
    proposalDescription = json['proposal_description'];
    status = json['status'];
    bidAmount = json['bid_amount'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['freelancer_id'] = this.freelancerId;
    data['freelancer_name'] = this.freelancerName;
    data['profile_image'] = this.profileImage;
    data['proposal_id'] = this.proposalId;
    data['proposal_description'] = this.proposalDescription;
    data['status'] = this.status;
    data['bid_amount'] = this.bidAmount;
    data['time'] = this.time;
    return data;
  }
}
