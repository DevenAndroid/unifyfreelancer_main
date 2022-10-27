import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../resources/helper.dart';
import '../models/model_reset_password.dart';
import '../utils/api_contant.dart';


Future<ModelResetPassword> resetPassword(
    email, password, confirm_password, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try {
    var map = <String, dynamic>{};

    map['email'] = email;
    map['password'] = password;
    map['confirm_password'] = confirm_password;

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http.post(Uri.parse(ApiUrls.resetPassword),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      return ModelResetPassword.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  }
  on SocketException {
    Helpers.hideLoader(loader);
    return ModelResetPassword(
        data: null,
        message: "No Internet Access",
        status: false);
  }
  catch (e){
    Helpers.hideLoader(loader);
    return ModelResetPassword(
        data: null,
        message: "Something went wrong...$e",
        status: false);
  }
}
