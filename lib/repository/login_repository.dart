import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/models/model_login.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../helper.dart';

Future<ModelLoginResponse> login(email, password, BuildContext context) async {
  var map = <String, dynamic>{};
  map['email'] = email;
  map['password'] = password;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.login),
      body: jsonEncode(map), headers: headers);

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Helpers.hideLoader(loader);
    return ModelLoginResponse.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    Helpers.hideLoader(loader);
    throw Exception('Failed to load album');
  }
}
