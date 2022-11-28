import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/model_subscription.dart';
import '../utils/api_contant.dart';


Future<ModelSubscriptionPlans> subscriptionPlansRepo() async {
  // OverlayEntry loader = Helpers.overlayLoader(context);
  // Overlay.of(context)!.insert(loader);
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http
        .get(Uri.parse(ApiUrls.subscriptionPlansUrl), headers: headers);
    if (response.statusCode == 200) {
      return ModelSubscriptionPlans.fromJson(jsonDecode(response.body));
    } else {
      return ModelSubscriptionPlans.fromJson(jsonDecode(response.body));
    }
  } on SocketException {
    return ModelSubscriptionPlans(
        status: false, message: "No Internet Access", data: null);
  } catch (e) {
    return ModelSubscriptionPlans(
        status: false, message: e.toString(), data: null);
  }
}
