class ModelLoginResponse {
  ModelLoginResponse({
    this.status,
    this.message,
    this.authToken,
    this.data,
  });
  bool? status;
  String? message;
  String? authToken;
  Data? data;

  ModelLoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    authToken = json['auth_token'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['auth_token'] = authToken;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.user,
  });
  late final User user;

  Data.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.status,
    this.referalCode,
    this.address,
    this.country,
    this.state,
    this.city,
    this.zipCode,
    this.profileImage,
    this.agreeTerms,
    this.sendEmail,
  });
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  bool? emailVerifiedAt;
  String? status;
  String? referalCode;
  String? address;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? profileImage;
  dynamic agreeTerms;
  dynamic sendEmail;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
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
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['status'] = status;
    _data['referal_code'] = referalCode;
    _data['address'] = address;
    _data['country'] = country;
    _data['state'] = state;
    _data['city'] = city;
    _data['zip_code'] = zipCode;
    _data['profile_image'] = profileImage;
    _data['agree_terms'] = agreeTerms;
    _data['send_email'] = sendEmail;
    return _data;
  }
}
