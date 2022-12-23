import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Model_common_response.dart';
import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelCommonResponse> editEmploymentInfoRepo({
  required id,
  required subject,
  required description,
  required company,
  required city,
  required country,
  required start_date,
  required end_date,
  required currently_working,
  context
}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  if(id != -10000){
    map['id'] = id;
  }
  map['subject'] = subject;
  map['description'] = description;
  map['company'] = company;
  map['city'] = city;
  map['country'] = country;
  map['start_date'] = start_date;
  if(currently_working == 0){
    map['end_date'] = end_date;
  }
  map['currently_working'] = currently_working;
  print(map);
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.editEmploymentInfo),
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
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: e.toString(), status: false);
  }
}

Future<ModelCommonResponse> questionEmployment({
  required id,
  required subject,
  required description,
  required company,
  required city,
  required country,
  required start_date,
  required end_date,
  required currently_working,
  context
}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  if(id != ""){
    map['id'] = id;
  }
  map['subject'] = subject;
  map['description'] = description;
  map['company'] = company;
  map['city'] = city;
  map['country'] = country;
  map['start_date'] = start_date;
  map['end_date'] = end_date;
  map['currently_working'] = currently_working;
  print(map);
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.editEmploymentInfo),
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
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: e.toString(), status: false);
  }
}