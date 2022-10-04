class ModelLoginResponse {
  ModelLoginResponse({
    required this.status,
    required this.message,
    required this.authToken,
    required this.data,
  });
  late final bool status;
  late final String message;
  late final String authToken;
  late final Data data;

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
    _data['data'] = data.toJson();
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
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.emailVerifiedAt,
    required this.status,
    required this.referalCode,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.profileImage,
    required this.agreeTerms,
    required this.sendEmail,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phone;
  late final bool emailVerifiedAt;
  late final String status;
  late final String referalCode;
  late final String address;
  late final String country;
  late final String state;
  late final String city;
  late final String zipCode;
  late final String profileImage;
  late final int agreeTerms;
  late final int sendEmail;

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
