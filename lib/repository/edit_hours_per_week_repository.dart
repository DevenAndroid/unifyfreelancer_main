import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unifyfreelancer/models/Model_common_response.dart';
import 'package:http/http.dart' as http;

import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelCommonResponse> editHoursPerWeekRepo({hours_id,required hours_price,required context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  map['hours_id'] = hours_id;
  map['hours_price'] = hours_price;
  if (kDebugMode) {
    print(map);
  }
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.editHoursPerWeek),
        headers: await getAuthHeader(),body: jsonEncode(map) );

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      return ModelCommonResponse.fromJson(jsonDecode(response.body));

    } else {
      Helpers.hideLoader(loader);
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
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