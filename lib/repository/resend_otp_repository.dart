import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/models/model_resend_otp.dart';

import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelResendOtpResponse> resendOtp(email, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try {
    var map = <String, dynamic>{};
    map['email'] = email;

    print(map);

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };


    http.Response response = await http.post(Uri.parse(ApiUrls.resendOtp),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      return ModelResendOtpResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      return ModelResendOtpResponse(
          data: null,
          message: jsonDecode(response.body)["message"],
          status: false);
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelResendOtpResponse(
        data: null,
        message: "No Internet Connection",
        status: false);
  } catch (e){
    Helpers.hideLoader(loader);
    return ModelResendOtpResponse(
        data: null,
        message: "Something went wrong...$e",
        status: false
    );
  }
}
