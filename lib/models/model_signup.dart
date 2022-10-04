class ModelSignUpResponse {
  ModelSignUpResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String message;
  late final Data data;

  ModelSignUpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.email,
    required this.otp,
  });
  late final String email;
  late final int otp;

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['otp'] = otp;
    return _data;
  }
}
