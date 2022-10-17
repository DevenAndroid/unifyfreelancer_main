import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unifyfreelancer/models/Model_common_response.dart';
import 'package:http/http.dart' as http;

import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelCommonResponse> editEducationInfoRepo(school, start_year, end_year,degree,area_study,description, context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  map['school'] = school;
  map['start_year'] = start_year;
  map['end_year'] = end_year;
  map['degree'] = degree;
  map['area_study'] = area_study;
  map['description'] = description;
  print(map);
  try {
    http.Response response = await http.post(
        Uri.parse(ApiUrls.editEducationInfo),
        headers: await getAuthHeader(),
        body: jsonEncode(map));

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      print(jsonDecode(response.body));
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      print(jsonDecode(response.body));
      return ModelCommonResponse(
          message: jsonDecode(response.body)["message"], status: false);
    }
  } on SocketException catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: e.toString(), status: false);
  }
}
