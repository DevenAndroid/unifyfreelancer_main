import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unifyfreelancer/models/Model_common_response.dart';
import 'package:http/http.dart' as http;

import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelCommonResponse> editTestimonialInfoRepo({first_name, last_name,
    email,/* linkdin_url,*/ title, type, description, context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  map['first_name'] = first_name;
  map['last_name'] = last_name;
  map['email'] = email;
  // map['linkdin_url'] = linkdin_url;
  map['title'] = title;
  map['type'] = type;
  map['description'] = description;
  print(map);
  try {
    http.Response response = await http.post(
        Uri.parse(ApiUrls.editTestimonialInfo),
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
