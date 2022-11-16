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
  String? id;
  String? clientId;
  String? image;
  String? name;
  String? type;
  String? description;
  String? budgetType;
  dynamic minPrice;
  dynamic price;
  String? projectDuration;
  String? scop;
  String? status;
  String? experienceLevel;
  String? categories;
  String? createdAt;
  List<Skills>? skills;
  List<ProposalList>? proposalList;
  ClientData? clientData;
  bool? isProposalSend;

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
        this.scop,
        this.status,
        this.experienceLevel,
        this.categories,
        this.createdAt,
        this.skills,
        this.proposalList,
        this.clientData,
        this.isProposalSend});

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
    scop = json['scop'];
    status = json['status'];
    experienceLevel = json['experience_level'];
    categories = json['categories'];
    createdAt = json['created_at'];
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
    clientData = json['client_data'] != null
        ? new ClientData.fromJson(json['client_data'])
        : null;
    isProposalSend = json['is_proposal_send'];
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
    data['scop'] = this.scop;
    data['status'] = this.status;
    data['experience_level'] = this.experienceLevel;
    data['categories'] = this.categories;
    data['created_at'] = this.createdAt;
    if (this.skills != null) {
      data['skills'] = this.skills!.map((v) => v.toJson()).toList();
    }
    if (this.proposalList != null) {
      data['proposal_list'] =
          this.proposalList!.map((v) => v.toJson()).toList();
    }
    if (this.clientData != null) {
      data['client_data'] = this.clientData!.toJson();
    }
    data['is_proposal_send'] = this.isProposalSend;
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
  String? amount;
  String? time;

  ProposalList(
      {this.freelancerId,
        this.freelancerName,
        this.profileImage,
        this.proposalId,
        this.proposalDescription,
        this.status,
        this.amount,
        this.time});

  ProposalList.fromJson(Map<String, dynamic> json) {
    freelancerId = json['freelancer_id'];
    freelancerName = json['freelancer_name'];
    profileImage = json['profile_image'];
    proposalId = json['proposal_id'];
    proposalDescription = json['proposal_description'];
    status = json['status'];
    amount = json['amount'];
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
    data['amount'] = this.amount;
    data['time'] = this.time;
    return data;
  }
}

class ClientData {
  String? id;
  String? profileImage;
  String? firstName;
  String? lastName;
  String? email;
  String? companyName;
  String? website;
  String? tagline;
  String? industry;
  String? employeeNo;
  String? description;
  String? companyPhone;
  String? vatId;
  String? timezone;
  String? companyAddress;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? isVerified;

  ClientData(
      {this.id,
        this.profileImage,
        this.firstName,
        this.lastName,
        this.email,
        this.companyName,
        this.website,
        this.tagline,
        this.industry,
        this.employeeNo,
        this.description,
        this.companyPhone,
        this.vatId,
        this.timezone,
        this.companyAddress,
        this.country,
        this.state,
        this.city,
        this.zipCode,
        this.isVerified});

  ClientData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profile_image'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    companyName = json['company_name'];
    website = json['website'];
    tagline = json['tagline'];
    industry = json['industry'];
    employeeNo = json['employee_no'];
    description = json['description'];
    companyPhone = json['company_phone'];
    vatId = json['vat_id'];
    timezone = json['timezone'];
    companyAddress = json['company_address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zip_code'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_image'] = this.profileImage;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['company_name'] = this.companyName;
    data['website'] = this.website;
    data['tagline'] = this.tagline;
    data['industry'] = this.industry;
    data['employee_no'] = this.employeeNo;
    data['description'] = this.description;
    data['company_phone'] = this.companyPhone;
    data['vat_id'] = this.vatId;
    data['timezone'] = this.timezone;
    data['company_address'] = this.companyAddress;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['is_verified'] = this.isVerified;
    return data;
  }
}
