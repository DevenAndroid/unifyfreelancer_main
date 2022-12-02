import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unifyfreelancer/models/Model_common_response.dart';
import 'package:http/http.dart' as http;

import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelCommonResponse> editLanguageRepo(map,context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  print(map);
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.editLanguage),
        headers: await getAuthHeader(),body: jsonEncode(map) );

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      print(jsonDecode(response.body));
      return ModelCommonResponse.fromJson(jsonDecode(response.body));

    } else {
      Helpers.hideLoader(loader);
      print(jsonDecode(response.body));
      return ModelCommonResponse(message: jsonDecode(response.body)["message"], status: false);
    }
  } on SocketException catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: e.toString(), status: false);
  }
}

Future<ModelCommonResponse> editFirstTime(map) async {
  print(map);
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.editLanguage),
        headers: await getAuthHeader(),body: jsonEncode(map) );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelCommonResponse.fromJson(jsonDecode(response.body));

    } else {
      print(jsonDecode(response.body));
      return ModelCommonResponse(message: jsonDecode(response.body)["message"], status: false);
    }
  } on SocketException {
    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {
    return ModelCommonResponse(message: e.toString(), status: false);
  }
}