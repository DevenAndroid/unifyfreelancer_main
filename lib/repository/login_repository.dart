import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../resources/helper.dart';
import '../models/model_login.dart';
import '../utils/api_contant.dart';

Future<ModelLoginResponse> login(email, password, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  //SharedPreferences pref = await SharedPreferences.getInstance();
  map['email'] = email;
  map['password'] = password;
  map['user_type'] = "freelancer";
  print(map);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  print(ApiUrls.login);

  http.Response response = await http.post(Uri.parse(ApiUrls.login),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelLoginResponse.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    Helpers.hideLoader(loader);
    // return ModelLoginResponse.fromJson(jsonDecode(response.body));
    return ModelLoginResponse(
        authToken: "",
        data: null,
        message: jsonDecode(response.body)["message"],
        status: false);
  } else {
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
