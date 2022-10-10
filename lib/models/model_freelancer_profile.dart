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
  List<Skills>? skills;
  List<Portfolio>? portfolio;
  List<Testimonial>? testimonial;
  List<Certificates>? certificates;
  List<Experiences>? experiences;
  List<Education>? education;

  Data(
      {this.basicInfo,
        this.skills,
        this.portfolio,
        this.testimonial,
        this.certificates,
        this.experiences,
        this.education});

  Data.fromJson(Map<String, dynamic> json) {
    basicInfo = json['basic_info'] != null
        ? new BasicInfo.fromJson(json['basic_info'])
        : null;
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
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences!.add(new Experiences.fromJson(v));
      });
    }
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(new Education.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basicInfo != null) {
      data['basic_info'] = this.basicInfo!.toJson();
    }
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
    if (this.experiences != null) {
      data['experiences'] = this.experiences!.map((v) => v.toJson()).toList();
    }
    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
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
  String? country;
  String? state;
  String? city;

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
        this.country,
        this.state,
        this.city});

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
    country = json['country'];
    state = json['state'];
    city = json['city'];
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
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
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
  String? firstName;
  String? lastName;
  String? email;
  String? linkdinUrl;
  String? title;
  String? type;
  String? description;

  Testimonial(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.linkdinUrl,
        this.title,
        this.type,
        this.description});

  Testimonial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    linkdinUrl = json['linkdin_url'];
    title = json['title'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['linkdin_url'] = this.linkdinUrl;
    data['title'] = this.title;
    data['type'] = this.type;
    data['description'] = this.description;
    return data;
  }
}

class Certificates {
  int? id;
  String? name;
  String? issueDate;
  String? expiryDate;
  String? certificateId;

  Certificates(
      {this.id,
        this.name,
        this.issueDate,
        this.expiryDate,
        this.certificateId});

  Certificates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    issueDate = json['issue_date'];
    expiryDate = json['expiry_date'];
    certificateId = json['certificate_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['issue_date'] = this.issueDate;
    data['expiry_date'] = this.expiryDate;
    data['certificate_id'] = this.certificateId;
    return data;
  }
}

class Experiences {
  int? id;
  Null? company;
  Null? city;
  Null? country;
  Null? startDate;
  Null? endDate;
  int? currentlyWorking;
  String? subject;
  String? description;

  Experiences(
      {this.id,
        this.company,
        this.city,
        this.country,
        this.startDate,
        this.endDate,
        this.currentlyWorking,
        this.subject,
        this.description});

  Experiences.fromJson(Map<String, dynamic> json) {
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
  String? date;
  String? level;
  String? degree;
  String? areaStudy;
  String? description;

  Education(
      {this.id,
        this.school,
        this.date,
        this.level,
        this.degree,
        this.areaStudy,
        this.description});

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    school = json['school'];
    date = json['date'];
    level = json['level'];
    degree = json['degree'];
    areaStudy = json['area_study'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school'] = this.school;
    data['date'] = this.date;
    data['level'] = this.level;
    data['degree'] = this.degree;
    data['area_study'] = this.areaStudy;
    data['description'] = this.description;
    return data;
  }
}
