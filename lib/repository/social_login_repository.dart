import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/helper.dart';
import '../models/model_login.dart';
import '../utils/api_contant.dart';

Future<ModelLoginResponse> socialLoginRepo({provider, accessToken,context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try {
    var map = <String, dynamic>{};
    map['provider'] = provider;
    map['token'] = accessToken;
    map['user_type'] = "freelancer";

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http.post(Uri.parse(ApiUrls.socialLoginUrl),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      return ModelLoginResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      return ModelLoginResponse(
          authToken: "",
          data: null,
          message: jsonDecode(response.body)["message"],
          status: false);
    }
  } on SocketException catch (e){
    return ModelLoginResponse(
        authToken: "",
        data: null,
        message: "No Internet Access",
        status: false);
  } catch(e){
    return ModelLoginResponse(
        authToken: "",
        data: null,
        message: e.toString(),
        status: false);
  }
}
