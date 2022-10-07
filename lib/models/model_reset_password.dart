class ModelResetPassword {
  bool? status;
  String? message;
  String? authToken;
  Data? data;

  ModelResetPassword({this.status, this.message, this.authToken, this.data});

  ModelResetPassword.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    authToken = json['auth_token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['auth_token'] = this.authToken;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  bool? emailVerifiedAt;
  String? status;
  String? onlineStatus;
  String? referalCode;
  String? address;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? profileImage;
  bool? agreeTerms;
  bool? sendEmail;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.emailVerifiedAt,
      this.status,
      this.onlineStatus,
      this.referalCode,
      this.address,
      this.country,
      this.state,
      this.city,
      this.zipCode,
      this.profileImage,
      this.agreeTerms,
      this.sendEmail});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    onlineStatus = json['online_status'];
    referalCode = json['referal_code'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zip_code'];
    profileImage = json['profile_image'];
    agreeTerms = json['agree_terms'];
    sendEmail = json['send_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['online_status'] = this.onlineStatus;
    data['referal_code'] = this.referalCode;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['profile_image'] = this.profileImage;
    data['agree_terms'] = this.agreeTerms;
    data['send_email'] = this.sendEmail;
    return data;
  }
}
