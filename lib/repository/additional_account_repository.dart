import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/Model_common_response.dart';
import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelCommonResponse> additionalAccountRepo({user_type,agency_name, context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  Map map = <String, dynamic>{};
  map["user_type"] = user_type;
  map["agency_name"] = agency_name;

  try {
    http.Response response = await http.post(
        Uri.parse(ApiUrls.additionalAccount),
        headers: await getAuthHeader(),
        body: jsonEncode(map));

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      print(jsonDecode(response.body));
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    }
    else {
      Helpers.hideLoader(loader);
      print(jsonDecode(response.body));
      return ModelCommonResponse(message: jsonDecode(response.body)["message"], status: false);
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: "No Internet Access", status: false);
  }
  catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: e.toString(), status: false);
  }
}
