import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/Model_common_response.dart';
import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelCommonResponse> submitProfileRepo() async {


  try {
    http.Response response = await http.get(
        Uri.parse(ApiUrls.submitProfile),
        headers: await getAuthHeader(),
        );

    if (response.statusCode == 200) {

      print(jsonDecode(response.body));
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {

      print(jsonDecode(response.body));
      return ModelCommonResponse(
          message: jsonDecode(response.body)["message"], status: false);
    }
  } on SocketException catch (e) {

    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {

    return ModelCommonResponse(message: e.toString(), status: false);
  }
}
