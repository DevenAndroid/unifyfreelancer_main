class ModelSubmittedProposal {
  bool? status;
  String? message;
  Data? data;

  ModelSubmittedProposal({this.status, this.message, this.data});

  ModelSubmittedProposal.fromJson(Map<String, dynamic> json) {
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
  ProposalData? proposalData;
  List<Milestonedata>? milestonedata;
  ClientData? clientData;
  ProjectData? projectData;

  Data(
      {this.proposalData,
        this.milestonedata,
        this.clientData,
        this.projectData});

  Data.fromJson(Map<String, dynamic> json) {
    proposalData = json['proposal_data'] != null
        ? new ProposalData.fromJson(json['proposal_data'])
        : null;
    if (json['milestonedata'] != null) {
      milestonedata = <Milestonedata>[];
      json['milestonedata'].forEach((v) {
        milestonedata!.add(new Milestonedata.fromJson(v));
      });
    }
    clientData = json['client_data'] != null
        ? new ClientData.fromJson(json['client_data'])
        : null;
    projectData = json['project_data'] != null
        ? new ProjectData.fromJson(json['project_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.proposalData != null) {
      data['proposal_data'] = this.proposalData!.toJson();
    }
    if (this.milestonedata != null) {
      data['milestonedata'] =
          this.milestonedata!.map((v) => v.toJson()).toList();
    }
    if (this.clientData != null) {
      data['client_data'] = this.clientData!.toJson();
    }
    if (this.projectData != null) {
      data['project_data'] = this.projectData!.toJson();
    }
    return data;
  }
}

class ProposalData {
  int? id;
  int? projectId;
  int? clientId;
  int? freelancerId;
  Null? inviteId;
  String? type;
  String? budgetType;
  Null? weeklyLimit;
  String? projectDuration;
  String? title;
  Null? date;
  String? coverLetter;
  String? image;
  String? status;
  String? additionalStatus;
  String? createdAt;
  String? updatedAt;
  int? bidAmount;

  ProposalData(
      {this.id,
        this.projectId,
        this.clientId,
        this.freelancerId,
        this.inviteId,
        this.type,
        this.budgetType,
        this.weeklyLimit,
        this.projectDuration,
        this.title,
        this.date,
        this.coverLetter,
        this.image,
        this.status,
        this.additionalStatus,
        this.createdAt,
        this.updatedAt,
        this.bidAmount});

  ProposalData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    clientId = json['client_id'];
    freelancerId = json['freelancer_id'];
    inviteId = json['invite_id'];
    type = json['type'];
    budgetType = json['budget_type'];
    weeklyLimit = json['weekly_limit'];
    projectDuration = json['project_duration'];
    title = json['title'];
    date = json['date'];
    coverLetter = json['cover_letter'];
    image = json['image'];
    status = json['status'];
    additionalStatus = json['additional_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bidAmount = json['bid_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['client_id'] = this.clientId;
    data['freelancer_id'] = this.freelancerId;
    data['invite_id'] = this.inviteId;
    data['type'] = this.type;
    data['budget_type'] = this.budgetType;
    data['weekly_limit'] = this.weeklyLimit;
    data['project_duration'] = this.projectDuration;
    data['title'] = this.title;
    data['date'] = this.date;
    data['cover_letter'] = this.coverLetter;
    data['image'] = this.image;
    data['status'] = this.status;
    data['additional_status'] = this.additionalStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['bid_amount'] = this.bidAmount;
    return data;
  }
}

class Milestonedata {
  dynamic id;
  dynamic proposalId;
  dynamic projectId;
  dynamic clientId;
  dynamic freelancerId;
  dynamic description;
  dynamic projectDuration;
  dynamic amount;
  dynamic dueDate;
  dynamic status;
  dynamic note;
  dynamic type;
  dynamic createdAt;
  dynamic updatedAt;

  Milestonedata(
      {this.id,
        this.proposalId,
        this.projectId,
        this.clientId,
        this.freelancerId,
        this.description,
        this.projectDuration,
        this.amount,
        this.dueDate,
        this.status,
        this.note,
        this.type,
        this.createdAt,
        this.updatedAt});

  Milestonedata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    proposalId = json['proposal_id'];
    projectId = json['project_id'];
    clientId = json['client_id'];
    freelancerId = json['freelancer_id'];
    description = json['description'];
    projectDuration = json['project_duration'];
    amount = json['amount'];
    dueDate = json['due_date'];
    status = json['status'];
    note = json['note'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['proposal_id'] = this.proposalId;
    data['project_id'] = this.projectId;
    data['client_id'] = this.clientId;
    data['freelancer_id'] = this.freelancerId;
    data['description'] = this.description;
    data['project_duration'] = this.projectDuration;
    data['amount'] = this.amount;
    data['due_date'] = this.dueDate;
    data['status'] = this.status;
    data['note'] = this.note;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ClientData {
  dynamic id;
  dynamic profileImage;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic companyName;
  dynamic website;
  dynamic tagline;
  dynamic industry;
  dynamic employeeNo;
  dynamic description;
  dynamic companyPhone;
  dynamic vatId;
  dynamic timezone;
  dynamic localTime;
  dynamic companyAddress;
  dynamic country;
  dynamic state;
  dynamic city;
  dynamic zipCode;
  dynamic isVerified;
  dynamic paymentVerified;
  dynamic rating;
  dynamic numberOfReview;
  dynamic jobPosted;
  dynamic moneySpent;
  dynamic ratePaidClient;
  dynamic memberSince;
  dynamic lastActivity;

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

class ProjectData {
  dynamic id;
  dynamic clientId;
  dynamic image;
  dynamic imageName;
  dynamic name;
  dynamic type;
  dynamic description;
  dynamic budgetType;
  dynamic minPrice;
 dynamic price;
  dynamic projectDuration;
  dynamic scop;
  dynamic status;
  dynamic experienceLevel;
  dynamic englishLevel;
  dynamic categories;
  dynamic categoryId;
  dynamic createdAt;
  dynamic postedDate;
  List<JobSkills>? jobSkills;
dynamic proposalList;
dynamic clientData;
dynamic isPrivate;
dynamic isProposalSend;
dynamic isSaved;
dynamic serviceFee;
dynamic proposalCount;
dynamic inviteSent;
dynamic unansweredInvite;
  dynamic interview;
  dynamic hireRate;
  dynamic openJobs;
  dynamic totalHire;
  dynamic totalActive;
  dynamic inviteId;
  dynamic isInvited;
  dynamic clientRecentHistory;

  ProjectData(
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
        this.categoryId,
        this.createdAt,
        this.postedDate,
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
        this.inviteId,
        this.isInvited,
        this.clientRecentHistory});

  ProjectData.fromJson(Map<String, dynamic> json) {
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
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    postedDate = json['posted_date'];
    if (json['job_skills'] != null) {
      jobSkills = <JobSkills>[];
      json['job_skills'].forEach((v) {
        jobSkills!.add(new JobSkills.fromJson(v));
      });
    }
    proposalList = json['proposal_list'];
    clientData = json['client_data'];
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
    inviteId = json['invite_id'];
    isInvited = json['is_invited'];
    clientRecentHistory = json['client_recent_history'];
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
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['posted_date'] = this.postedDate;
    if (this.jobSkills != null) {
      data['job_skills'] = this.jobSkills!.map((v) => v.toJson()).toList();
    }
    data['proposal_list'] = this.proposalList;
    data['client_data'] = this.clientData;
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
    data['invite_id'] = this.inviteId;
    data['is_invited'] = this.isInvited;
    data['client_recent_history'] = this.clientRecentHistory;
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
