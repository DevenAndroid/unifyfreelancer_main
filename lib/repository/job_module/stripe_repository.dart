import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../models/Model_common_response.dart';
import '../../resources/helper.dart';
import '../../utils/api_contant.dart';


Future<ModelCommonResponse> stripePayRepo({
  required subscriptionId,
  required stripeToken,
  required context
}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try {
    Map<String, dynamic> map = {};
    map["subscription_id"] = subscriptionId;
    map["stripe_token"] = stripeToken;
    if (kDebugMode) {
      print(map.toString());
    }

    final headers = await getAuthHeader();

    http.Response response = await http.post(Uri.parse(ApiUrls.stripePayUrl),
        body: jsonEncode(map), headers: headers);
    Helpers.hideLoader(loader);
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(
        status: false, message: "No Internet Access");
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(status: false, message: e.toString());
  }
}
