class ModelFreelancerProfile {
  bool? status;
  String? message;
  Data? data;

  ModelFreelancerProfile({this.status, this.message, this.data});

  ModelFreelancerProfile.fromJson(Map<String, dynamic> json) {
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
  BasicInfo? basicInfo;
  bool? isClient;
  bool? isAgency;
  List<Skills>? skills;
  List<Portfolio>? portfolio;
  List<Testimonial>? testimonial;
  List<Certificates>? certificates;
  List<Employment>? employment;
  List<Education>? education;
  List<Language>? language;
  String? hoursPerWeek;
  Video? video;

  Data(
      {this.basicInfo,
        this.isClient,
        this.isAgency,
        this.skills,
        this.portfolio,
        this.testimonial,
        this.certificates,
        this.employment,
        this.education,
        this.language,
        this.hoursPerWeek,
        this.video});

  Data.fromJson(Map<String, dynamic> json) {
    basicInfo = json['basic_info'] != null
        ? new BasicInfo.fromJson(json['basic_info'])
        : null;
    isClient = json['is_client'];
    isAgency = json['is_agency'];
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(new Skills.fromJson(v));
      });
    }
    if (json['portfolio'] != null) {
      portfolio = <Portfolio>[];
      json['portfolio'].forEach((v) {
        portfolio!.add(new Portfolio.fromJson(v));
      });
    }
    if (json['testimonial'] != null) {
      testimonial = <Testimonial>[];
      json['testimonial'].forEach((v) {
        testimonial!.add(new Testimonial.fromJson(v));
      });
    }
    if (json['certificates'] != null) {
      certificates = <Certificates>[];
      json['certificates'].forEach((v) {
        certificates!.add(new Certificates.fromJson(v));
      });
    }
    if (json['employment'] != null) {
      employment = <Employment>[];
      json['employment'].forEach((v) {
        employment!.add(new Employment.fromJson(v));
      });
    }
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(new Education.fromJson(v));
      });
    }
    if (json['language'] != null) {
      language = <Language>[];
      json['language'].forEach((v) {
        language!.add(new Language.fromJson(v));
      });
    }
    hoursPerWeek = json['hours_per_week'];
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basicInfo != null) {
      data['basic_info'] = this.basicInfo!.toJson();
    }
    data['is_client'] = this.isClient;
    data['is_agency'] = this.isAgency;
    if (this.skills != null) {
      data['skills'] = this.skills!.map((v) => v.toJson()).toList();
    }
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.map((v) => v.toJson()).toList();
    }
    if (this.testimonial != null) {
      data['testimonial'] = this.testimonial!.map((v) => v.toJson()).toList();
    }
    if (this.certificates != null) {
      data['certificates'] = this.certificates!.map((v) => v.toJson()).toList();
    }
    if (this.employment != null) {
      data['employment'] = this.employment!.map((v) => v.toJson()).toList();
    }
    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
    }
    if (this.language != null) {
      data['language'] = this.language!.map((v) => v.toJson()).toList();
    }
    data['hours_per_week'] = this.hoursPerWeek;
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    return data;
  }
}

class BasicInfo {
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
  String? address;
  String? phone;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? isVerified;

  BasicInfo(
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

  BasicInfo.fromJson(Map<String, dynamic> json) {
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

class Skills {
  int? id;
  int? skillId;
  String? skillName;

  Skills({this.id, this.skillId, this.skillName});

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skillId = json['skill_id'];
    skillName = json['skill_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['skill_id'] = this.skillId;
    data['skill_name'] = this.skillName;
    return data;
  }
}

class Portfolio {
  int? id;
  String? name;
  String? description;
  String? image;

  Portfolio({this.id, this.name, this.description, this.image});

  Portfolio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}

class Testimonial {
  int? id;
  String? message;
  String? requestSent;
  String? status;
  String? firstName;
  String? lastName;
  String? email;
  String? title;
  String? type;
  String? description;

  Testimonial(
      {this.id,
        this.message,
        this.requestSent,
        this.status,
        this.firstName,
        this.lastName,
        this.email,
        this.title,
        this.type,
        this.description});

  Testimonial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    requestSent = json['request_sent'];
    status = json['status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    title = json['title'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['request_sent'] = this.requestSent;
    data['status'] = this.status;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['title'] = this.title;
    data['type'] = this.type;
    data['description'] = this.description;
    return data;
  }
}

class Certificates {
  int? id;
  String? name;
  String? description;

  Certificates({this.id, this.name, this.description});

  Certificates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class Employment {
  int? id;
  String? company;
  String? city;
  String? country;
  String? startDate;
  String? endDate;
  int? currentlyWorking;
  String? subject;
  String? description;

  Employment(
      {this.id,
        this.company,
        this.city,
        this.country,
        this.startDate,
        this.endDate,
        this.currentlyWorking,
        this.subject,
        this.description});

  Employment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'];
    city = json['city'];
    country = json['country'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    currentlyWorking = json['currently_working'];
    subject = json['subject'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company'] = this.company;
    data['city'] = this.city;
    data['country'] = this.country;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['currently_working'] = this.currentlyWorking;
    data['subject'] = this.subject;
    data['description'] = this.description;
    return data;
  }
}

class Education {
  int? id;
  String? school;
  String? startYear;
  String? endYear;
  String? level;
  String? degree;
  String? areaStudy;
  String? description;

  Education(
      {this.id,
        this.school,
        this.startYear,
        this.endYear,
        this.level,
        this.degree,
        this.areaStudy,
        this.description});

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    school = json['school'];
    startYear = json['start_year'];
    endYear = json['end_year'];
    level = json['level'];
    degree = json['degree'];
    areaStudy = json['area_study'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school'] = this.school;
    data['start_year'] = this.startYear;
    data['end_year'] = this.endYear;
    data['level'] = this.level;
    data['degree'] = this.degree;
    data['area_study'] = this.areaStudy;
    data['description'] = this.description;
    return data;
  }
}

class Language {
  String? language;
  String? level;

  Language({this.language, this.level});

  Language.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['level'] = this.level;
    return data;
  }
}

class Video {
  String? url;
  String? type;

  Video({this.url, this.type});

  Video.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}
