import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../../models/Model_common_response.dart';
import '../../resources/helper.dart';

Future<ModelCommonResponse> removeDislikeJobRepo({job_id, context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  Map map = <String, dynamic>{};
  map["job_id"] = job_id;
  print(map);

  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.dislikeReasons),
        headers: await getAuthHeader(), body: jsonEncode(map));

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
  } on SocketException {
    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {
    return ModelCommonResponse(message: e.toString(), status: false);
  }
}
