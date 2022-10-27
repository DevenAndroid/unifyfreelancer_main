
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../resources/helper.dart';
import '../models/model_verify_signup.dart';

Future<ModelVerificationSignUp> verifySignUp(email,otp,context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try {
    Map<String, dynamic> map = {};
    map["email"] = email;
    map["otp"] = otp;

    print(map);
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    final response = await http.post(
        Uri.parse(ApiUrls.verifySignUp),
        body: jsonEncode(map),
        headers: headers
    );
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      return ModelVerificationSignUp.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      return ModelVerificationSignUp(
          authToken: "",
          data: null,
          message: jsonDecode(response.body)["message"],
          status: false);
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelVerificationSignUp(
        authToken: "",
        data: null,
        message: "No Internet Connection",
        status: false);
  } catch (e){
    Helpers.hideLoader(loader);
    return ModelVerificationSignUp(
        authToken: "",
        data: null,
        message: "Something went wrong...$e",
        status: false);
  }
}