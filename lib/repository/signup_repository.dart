import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/models/model_signup.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../helper.dart';

Future<ModelSignUpResponse> signUp(
    firstName,
    lastName,
    email,
    password,
    country,
    userType,
    referalCode,
    agreeTerms,
    sendEmail,
    BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  map['first_name'] = firstName;
  map['last_name'] = lastName;
  map['email'] = email;
  map['password'] = password;
  map['country'] = country;
  map['user_type'] = userType;
  map['referal_code'] = referalCode;
  map['agree_terms'] = agreeTerms;
  map['send_email'] = 0;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  log("Signup Request::=>" + map.toString());

  http.Response response = await http.post(Uri.parse(ApiUrls.signUp),
      body: jsonEncode(map), headers: headers);



  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelSignUpResponse.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    Helpers.hideLoader(loader);
    // return ModelLoginResponse.fromJson(jsonDecode(response.body));
    return ModelSignUpResponse(
        data: null,
        message: jsonDecode(response.body)["message"],
        status: false);
  } else {
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
