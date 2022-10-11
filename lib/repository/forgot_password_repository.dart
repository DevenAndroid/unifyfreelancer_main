import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../resources/helper.dart';
import '../models/model_forgot_password.dart';
import '../utils/api_contant.dart';

Future<ModelForgotPasswordResponse> forgotPassword(email, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  //SharedPreferences pref = await SharedPreferences.getInstance();
  map['email'] = email;

  print(map);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };


  http.Response response = await http.post(Uri.parse(ApiUrls.forgotPassword),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelForgotPasswordResponse.fromJson(jsonDecode(response.body));

  } else if (response.statusCode == 400) {
    Helpers.hideLoader(loader);
    // return ModelLoginResponse.fromJson(jsonDecode(response.body));
    return ModelForgotPasswordResponse(
        data: null,
        message: jsonDecode(response.body)["message"],
        status: false);
  } else {
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
