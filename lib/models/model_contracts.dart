class ModelContracts {
  bool? status;
  String? message;
  Data? data;

  ModelContracts({this.status, this.message, this.data});

  ModelContracts.fromJson(Map<String, dynamic> json) {
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
  List<All>? all;
  List<All>? hourly;
  List<All>? activeMilestone;
  List<All>? awaitingMilestone;
  List<All>? paymentRequest;

  Data(
      {this.all,
        this.hourly,
        this.activeMilestone,
        this.awaitingMilestone,
        this.paymentRequest});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['All'] != null) {
      all = <All>[];
      json['All'].forEach((v) {
        all!.add(new All.fromJson(v));
      });
    }
    if (json['Hourly'] != null) {
      hourly = <All>[];
      json['Hourly'].forEach((v) {
        hourly!.add(new All.fromJson(v));
      });
    }
    if (json['ActiveMilestone'] != null) {
      activeMilestone = <All>[];
      json['ActiveMilestone'].forEach((v) {
        activeMilestone!.add(new All.fromJson(v));
      });
    }
    if (json['AwaitingMilestone'] != null) {
      awaitingMilestone = <All>[];
      json['AwaitingMilestone'].forEach((v) {
        awaitingMilestone!.add(new All.fromJson(v));
      });
    }
    if (json['PaymentRequest'] != null) {
      /*paymentRequest = <Null>[];
      json['PaymentRequest'].forEach((v) {
        paymentRequest!.add(new Null.fromJson(v));
      });*/
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.all != null) {
      data['All'] = this.all!.map((v) => v.toJson()).toList();
    }
    if (this.hourly != null) {
      data['Hourly'] = this.hourly!.map((v) => v.toJson()).toList();
    }
    if (this.activeMilestone != null) {
      data['ActiveMilestone'] =
          this.activeMilestone!.map((v) => v.toJson()).toList();
    }
    if (this.awaitingMilestone != null) {
      data['AwaitingMilestone'] =
          this.awaitingMilestone!.map((v) => v.toJson()).toList();
    }
   /* if (this.paymentRequest != null) {
      data['PaymentRequest'] =
          this.paymentRequest!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class All {
  String? id;
  String? type;
  String? projectId;
  String? projectTitle;
  String? proposalId;
  String? startTime;
  String? endTime;
  String? clientId;
  String? freelancerId;
  String? amount;
  String? status;
  Project? project;
  Proposal? proposal;
  Client? client;
  Freelancer? freelancer;
  String? createdAt;

  All(
      {this.id,
        this.type,
        this.projectId,
        this.projectTitle,
        this.proposalId,
        this.startTime,
        this.endTime,
        this.clientId,
        this.freelancerId,
        this.amount,
        this.status,
        this.project,
        this.proposal,
        this.client,
        this.freelancer,
        this.createdAt});

  All.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    projectId = json['project_id'];
    projectTitle = json['project_title'];
    proposalId = json['proposal_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    clientId = json['client_id'];
    freelancerId = json['freelancer_id'];
    amount = json['amount'];
    status = json['status'];
    project =
    json['project'] != null ? new Project.fromJson(json['project']) : null;
    proposal = json['proposal'] != null
        ? new Proposal.fromJson(json['proposal'])
        : null;
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
    freelancer = json['freelancer'] != null
        ? new Freelancer.fromJson(json['freelancer'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['project_id'] = this.projectId;
    data['project_title'] = this.projectTitle;
    data['proposal_id'] = this.proposalId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['client_id'] = this.clientId;
    data['freelancer_id'] = this.freelancerId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    if (this.proposal != null) {
      data['proposal'] = this.proposal!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.freelancer != null) {
      data['freelancer'] = this.freelancer!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Project {
  String? id;
  String? clientId;
  String? image;
  String? name;
  String? type;
  String? description;
  String? budgetType;
  String? minPrice;
  dynamic price;
  String? projectDuration;
  String? status;
  String? experienceLevel;
  String? categories;
  List<dynamic>? skills;
  dynamic proposalList;
  dynamic clientData;

  Project(
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

  Project.fromJson(Map<String, dynamic> json) {
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
    // if (json['skills'] != null) {
    //   skills = <Null>[];
    //   json['skills'].forEach((v) {
    //     skills!.add(new Null.fromJson(v));
    //   });
    // }
    proposalList = json['proposal_list'];
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
    // if (this.skills != null) {
    //   data['skills'] = this.skills!.map((v) => v.toJson()).toList();
    // }
    data['proposal_list'] = this.proposalList;
    data['client_data'] = this.clientData;
    return data;
  }
}

class Proposal {
  String? id;
  String? jobId;
  String? userId;
  String? bidAmount;
  String? receiveAmount;
  String? projectDuration;
  String? coverLetter;
  String? status;
  String? platformFee;
  String? image;

  Proposal(
      {this.id,
        this.jobId,
        this.userId,
        this.bidAmount,
        this.receiveAmount,
        this.projectDuration,
        this.coverLetter,
        this.status,
        this.platformFee,
        this.image});

  Proposal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    userId = json['user_id'];
    bidAmount = json['bid_amount'];
    receiveAmount = json['receive_amount'];
    projectDuration = json['project_duration'];
    coverLetter = json['cover_letter'];
    status = json['status'];
    platformFee = json['platform_fee'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['user_id'] = this.userId;
    data['bid_amount'] = this.bidAmount;
    data['receive_amount'] = this.receiveAmount;
    data['project_duration'] = this.projectDuration;
    data['cover_letter'] = this.coverLetter;
    data['status'] = this.status;
    data['platform_fee'] = this.platformFee;
    data['image'] = this.image;
    return data;
  }
}

class Client {
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

  Client(
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

  Client.fromJson(Map<String, dynamic> json) {
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

class Freelancer {
  String? id;
  String? profileImage;
  String? visibility;
  String? projectPreference;
  String? experienceLevel;
  String? firstName;
  String? lastName;
  String? email;
  String? occuption;
  String? description;
  String? rating;
  dynamic totalEarning;
  dynamic totalJobs;
  dynamic totalHours;
  dynamic pendingProject;
  String? amount;
  String? timezone;
  String? address;
  String? phone;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? isVerified;

  Freelancer(
      {this.id,
        this.profileImage,
        this.visibility,
        this.projectPreference,
        this.experienceLevel,
        this.firstName,
        this.lastName,
        this.email,
        this.occuption,
        this.description,
        this.rating,
        this.totalEarning,
        this.totalJobs,
        this.totalHours,
        this.pendingProject,
        this.amount,
        this.timezone,
        this.address,
        this.phone,
        this.country,
        this.state,
        this.city,
        this.zipCode,
        this.isVerified});

  Freelancer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profile_image'];
    visibility = json['visibility'];
    projectPreference = json['project_preference'];
    experienceLevel = json['experience_level'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    occuption = json['occuption'];
    description = json['description'];
    rating = json['rating'];
    totalEarning = json['total_earning'];
    totalJobs = json['total_jobs'];
    totalHours = json['total_hours'];
    pendingProject = json['pending_project'];
    amount = json['amount'];
    timezone = json['timezone'];
    address = json['address'];
    phone = json['phone'];
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
    data['visibility'] = this.visibility;
    data['project_preference'] = this.projectPreference;
    data['experience_level'] = this.experienceLevel;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['occuption'] = this.occuption;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['total_earning'] = this.totalEarning;
    data['total_jobs'] = this.totalJobs;
    data['total_hours'] = this.totalHours;
    data['pending_project'] = this.pendingProject;
    data['amount'] = this.amount;
    data['timezone'] = this.timezone;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['is_verified'] = this.isVerified;
    return data;
  }
}
