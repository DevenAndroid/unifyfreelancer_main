import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../../models/model_dislike_reasons.dart';

Future<ModelDislikeReasons> dislikeReasonsRepo() async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.dislikeReasons),
        headers: await getAuthHeader());

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelDislikeReasons.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelDislikeReasons(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } on SocketException {
    return ModelDislikeReasons(message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelDislikeReasons(
        message: e.toString(), status: false, data: null);
  }
}
