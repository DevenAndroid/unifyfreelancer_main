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
  String? imageName;
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
  String? englishLevel;
  String? categories;
  String? createdAt;
  List<JobSkills>? jobSkills;
  List<ProposalList>? proposalList;
  ClientData? clientData;
  bool? isPrivate;
  bool? isProposalSend;
  bool? isSaved;
  String? serviceFee;
  dynamic proposalCount;
  dynamic inviteSent;
  dynamic unansweredInvite;
  dynamic interview;
  dynamic hireRate;
  dynamic openJobs;
  dynamic totalHire;
  dynamic totalActive;
  List<ClientRecentHistory>? clientRecentHistory;

  Data(
      {this.id,
        this.clientId,
        this.image,
        this.imageName,
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
        this.englishLevel,
        this.categories,
        this.createdAt,
        this.jobSkills,
        this.proposalList,
        this.clientData,
        this.isPrivate,
        this.isProposalSend,
        this.isSaved,
        this.serviceFee,
        this.proposalCount,
        this.inviteSent,
        this.unansweredInvite,
        this.interview,
        this.hireRate,
        this.openJobs,
        this.totalHire,
        this.totalActive,
        this.clientRecentHistory});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    image = json['image'];
    imageName = json['image_name'];
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
    englishLevel = json['english_level'];
    categories = json['categories'];
    createdAt = json['created_at'];
    if (json['job_skills'] != null) {
      jobSkills = <JobSkills>[];
      json['job_skills'].forEach((v) {
        jobSkills!.add(new JobSkills.fromJson(v));
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
    isPrivate = json['is_private'];
    isProposalSend = json['is_proposal_send'];
    isSaved = json['is_saved'];
    serviceFee = json['service_fee'];
    proposalCount = json['proposal_count'];
    inviteSent = json['invite_sent'];
    unansweredInvite = json['unanswered_invite'];
    interview = json['interview'];
    hireRate = json['hire_rate'];
    openJobs = json['open_jobs'];
    totalHire = json['total_hire'];
    totalActive = json['total_Active'];
    if (json['client_recent_history'] != null) {
      clientRecentHistory = <ClientRecentHistory>[];
      json['client_recent_history'].forEach((v) {
        clientRecentHistory!.add(new ClientRecentHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['image'] = this.image;
    data['image_name'] = this.imageName;
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
    data['english_level'] = this.englishLevel;
    data['categories'] = this.categories;
    data['created_at'] = this.createdAt;
    if (this.jobSkills != null) {
      data['job_skills'] = this.jobSkills!.map((v) => v.toJson()).toList();
    }
    if (this.proposalList != null) {
      data['proposal_list'] =
          this.proposalList!.map((v) => v.toJson()).toList();
    }
    if (this.clientData != null) {
      data['client_data'] = this.clientData!.toJson();
    }
    data['is_private'] = this.isPrivate;
    data['is_proposal_send'] = this.isProposalSend;
    data['is_saved'] = this.isSaved;
    data['service_fee'] = this.serviceFee;
    data['proposal_count'] = this.proposalCount;
    data['invite_sent'] = this.inviteSent;
    data['unanswered_invite'] = this.unansweredInvite;
    data['interview'] = this.interview;
    data['hire_rate'] = this.hireRate;
    data['open_jobs'] = this.openJobs;
    data['total_hire'] = this.totalHire;
    data['total_Active'] = this.totalActive;
    if (this.clientRecentHistory != null) {
      data['client_recent_history'] =
          this.clientRecentHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobSkills {
  String? id;
  String? name;

  JobSkills({this.id, this.name});

  JobSkills.fromJson(Map<String, dynamic> json) {
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
  dynamic proposalAmount;
  dynamic hourRate;
  String? time;
  List<Skills>? skills;

  ProposalList(
      {this.freelancerId,
        this.freelancerName,
        this.profileImage,
        this.proposalId,
        this.proposalDescription,
        this.status,
        this.proposalAmount,
        this.hourRate,
        this.time,
        this.skills});

  ProposalList.fromJson(Map<String, dynamic> json) {
    freelancerId = json['freelancer_id'];
    freelancerName = json['freelancer_name'];
    profileImage = json['profile_image'];
    proposalId = json['proposal_id'];
    proposalDescription = json['proposal_description'];
    status = json['status'];
    proposalAmount = json['proposal_amount'];
    hourRate = json['hour_rate'];
    time = json['time'];
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(new Skills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['freelancer_id'] = this.freelancerId;
    data['freelancer_name'] = this.freelancerName;
    data['profile_image'] = this.profileImage;
    data['proposal_id'] = this.proposalId;
    data['proposal_description'] = this.proposalDescription;
    data['status'] = this.status;
    data['proposal_amount'] = this.proposalAmount;
    data['hour_rate'] = this.hourRate;
    data['time'] = this.time;
    if (this.skills != null) {
      data['skills'] = this.skills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Skills {
  int? skillId;
  String? skillName;

  Skills({this.skillId, this.skillName});

  Skills.fromJson(Map<String, dynamic> json) {
    skillId = json['skill_id'];
    skillName = json['skill_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skill_id'] = this.skillId;
    data['skill_name'] = this.skillName;
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
  String? localTime;
  String? companyAddress;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? isVerified;
  bool? paymentVerified;
  String? rating;
  String? numberOfReview;
  String? jobPosted;
  String? moneySpent;
  String? ratePaidClient;
  String? memberSince;
  String? lastActivity;

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
        this.localTime,
        this.companyAddress,
        this.country,
        this.state,
        this.city,
        this.zipCode,
        this.isVerified,
        this.paymentVerified,
        this.rating,
        this.numberOfReview,
        this.jobPosted,
        this.moneySpent,
        this.ratePaidClient,
        this.memberSince,
        this.lastActivity});

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
    localTime = json['local_time'];
    companyAddress = json['company_address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zip_code'];
    isVerified = json['is_verified'];
    paymentVerified = json['payment_verified'];
    rating = json['rating'];
    numberOfReview = json['number_of_review'];
    jobPosted = json['job_posted'];
    moneySpent = json['money_spent'];
    ratePaidClient = json['rate_paid_client'];
    memberSince = json['member_since'];
    lastActivity = json['last_activity'];
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
    data['local_time'] = this.localTime;
    data['company_address'] = this.companyAddress;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['is_verified'] = this.isVerified;
    data['payment_verified'] = this.paymentVerified;
    data['rating'] = this.rating;
    data['number_of_review'] = this.numberOfReview;
    data['job_posted'] = this.jobPosted;
    data['money_spent'] = this.moneySpent;
    data['rate_paid_client'] = this.ratePaidClient;
    data['member_since'] = this.memberSince;
    data['last_activity'] = this.lastActivity;
    return data;
  }
}

class ClientRecentHistory {
  String? name;
  String? description;
  String? startDate;
  String? endDate;
  dynamic minPrice;
  dynamic rating;
  dynamic price;

  ClientRecentHistory(
      {this.name,
        this.description,
        this.startDate,
        this.endDate,
        this.minPrice,
        this.rating,
        this.price});

  ClientRecentHistory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    minPrice = json['min_price'];
    rating = json['rating'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['min_price'] = this.minPrice;
    data['rating'] = this.rating;
    data['price'] = this.price;
    return data;
  }
}
