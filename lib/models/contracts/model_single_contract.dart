class ModelSingleContract {
  bool? status;
  String? message;
  Data? data;

  ModelSingleContract({this.status, this.message, this.data});

  ModelSingleContract.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? type;
  String? weeklyLimit;
  int? projectId;
  String? projectTitle;
  int? proposalId;
  String? startTime;
  String? endTime;
  int? clientId;
  int? freelancerId;
  int? amount;
  int? inEscrow;
  String? status;
  String? activeStatus;
  String? createdAt;
  Project? project;
  Proposal? proposal;
  List<Milestone>? milestone;
  Client? client;
  Freelancer? freelancer;

  Data(
      {this.id,
        this.type,
        this.weeklyLimit,
        this.projectId,
        this.projectTitle,
        this.proposalId,
        this.startTime,
        this.endTime,
        this.clientId,
        this.freelancerId,
        this.amount,
        this.inEscrow,
        this.status,
        this.activeStatus,
        this.createdAt,
        this.project,
        this.proposal,
        this.milestone,
        this.client,
        this.freelancer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    weeklyLimit = json['weekly_limit'];
    projectId = json['project_id'];
    projectTitle = json['project_title'];
    proposalId = json['proposal_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    clientId = json['client_id'];
    freelancerId = json['freelancer_id'];
    amount = json['amount'];
    inEscrow = json['in_escrow'];
    status = json['status'];
    activeStatus = json['active_status'];
    createdAt = json['created_at'];
    project =
    json['project'] != null ? new Project.fromJson(json['project']) : null;
    proposal = json['proposal'] != null
        ? new Proposal.fromJson(json['proposal'])
        : null;
    if (json['milestone'] != null) {
      milestone = <Milestone>[];
      json['milestone'].forEach((v) {
        milestone!.add(new Milestone.fromJson(v));
      });
    }
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
    freelancer = json['freelancer'] != null
        ? new Freelancer.fromJson(json['freelancer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['weekly_limit'] = this.weeklyLimit;
    data['project_id'] = this.projectId;
    data['project_title'] = this.projectTitle;
    data['proposal_id'] = this.proposalId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['client_id'] = this.clientId;
    data['freelancer_id'] = this.freelancerId;
    data['amount'] = this.amount;
    data['in_escrow'] = this.inEscrow;
    data['status'] = this.status;
    data['active_status'] = this.activeStatus;
    data['created_at'] = this.createdAt;
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    if (this.proposal != null) {
      data['proposal'] = this.proposal!.toJson();
    }
    if (this.milestone != null) {
      data['milestone'] = this.milestone!.map((v) => v.toJson()).toList();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.freelancer != null) {
      data['freelancer'] = this.freelancer!.toJson();
    }
    return data;
  }
}

class Project {
  String? id;
  String? clientId;
  String? image;
  String? imageName;
  String? name;
  String? type;
  String? description;
  String? budgetType;
  int? minPrice;
  int? price;
  String? projectDuration;
  String? scop;
  String? status;
  String? experienceLevel;
  String? englishLevel;
  String? categories;
  String? categoryId;
  String? createdAt;
  String? postedDate;
  List<JobSkills>? jobSkills;
  Null? proposalList;
  Null? clientData;
  bool? isPrivate;
  bool? isProposalSend;
  bool? isSaved;
  int? serviceFee;
  int? proposalCount;
  Null? inviteSent;
  Null? unansweredInvite;
  int? interview;
  int? hireRate;
  int? openJobs;
  int? totalHire;
  int? totalActive;
  int? inviteId;
  bool? isSendOffer;
  int? offerId;
  bool? isInvited;
  Null? clientRecentHistory;

  Project(
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
        this.isSendOffer,
        this.offerId,
        this.isInvited,
        this.clientRecentHistory});

  Project.fromJson(Map<String, dynamic> json) {
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
    isSendOffer = json['isSendOffer'];
    offerId = json['offer_id'];
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
    data['isSendOffer'] = this.isSendOffer;
    data['offer_id'] = this.offerId;
    data['is_invited'] = this.isInvited;
    data['client_recent_history'] = this.clientRecentHistory;
    return data;
  }
}

class JobSkills {
  int? id;
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

class Milestone {
  int? id;
  int? proposalId;
  int? projectId;
  int? clientId;
  int? freelancerId;
  String? description;
  Null? projectDuration;
  int? amount;
  String? dueDate;
  String? status;
  String? note;
  String? type;
  String? createdAt;
  String? updatedAt;

  Milestone(
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

  Milestone.fromJson(Map<String, dynamic> json) {
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
  int? jobPosted;
  String? moneySpent;
  String? ratePaidClient;
  String? memberSince;
  String? onlineStatus;
  String? subscriptionId;
  bool? isSubscription;
  String? lastActivity;
  bool? isDeleted;

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
        this.onlineStatus,
        this.subscriptionId,
        this.isSubscription,
        this.lastActivity,
        this.isDeleted});

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
    onlineStatus = json['online_status'];
    subscriptionId = json['subscription_id'];
    isSubscription = json['is_subscription'];
    lastActivity = json['last_activity'];
    isDeleted = json['is_deleted'];
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
    data['online_status'] = this.onlineStatus;
    data['subscription_id'] = this.subscriptionId;
    data['is_subscription'] = this.isSubscription;
    data['last_activity'] = this.lastActivity;
    data['is_deleted'] = this.isDeleted;
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
  int? totalEarning;
  int? totalJobs;
  int? totalHours;
  int? pendingProject;
  String? amount;
  String? timezone;
  String? localTime;
  String? address;
  String? phone;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? hoursPerWeek;
  int? hoursPerWeekId;
  String? categoryId;
  String? category;
  String? isVerified;
  bool? isProfileComplete;
  String? successRate;
  String? onlineStatus;
  String? subscriptionId;
  bool? isSubscription;
  bool? isSaveTalent;
  bool? isDeleted;

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
        this.localTime,
        this.address,
        this.phone,
        this.country,
        this.state,
        this.city,
        this.zipCode,
        this.hoursPerWeek,
        this.hoursPerWeekId,
        this.categoryId,
        this.category,
        this.isVerified,
        this.isProfileComplete,
        this.successRate,
        this.onlineStatus,
        this.subscriptionId,
        this.isSubscription,
        this.isSaveTalent,
        this.isDeleted});

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
    localTime = json['local_time'];
    address = json['address'];
    phone = json['phone'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zip_code'];
    hoursPerWeek = json['hours_per_week'];
    hoursPerWeekId = json['hours_per_week_id'];
    categoryId = json['category_id'];
    category = json['category'];
    isVerified = json['is_verified'];
    isProfileComplete = json['is_profile_complete'];
    successRate = json['success_rate'];
    onlineStatus = json['online_status'];
    subscriptionId = json['subscription_id'];
    isSubscription = json['is_subscription'];
    isSaveTalent = json['isSaveTalent'];
    isDeleted = json['is_deleted'];
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
    data['local_time'] = this.localTime;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['hours_per_week'] = this.hoursPerWeek;
    data['hours_per_week_id'] = this.hoursPerWeekId;
    data['category_id'] = this.categoryId;
    data['category'] = this.category;
    data['is_verified'] = this.isVerified;
    data['is_profile_complete'] = this.isProfileComplete;
    data['success_rate'] = this.successRate;
    data['online_status'] = this.onlineStatus;
    data['subscription_id'] = this.subscriptionId;
    data['is_subscription'] = this.isSubscription;
    data['isSaveTalent'] = this.isSaveTalent;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}
