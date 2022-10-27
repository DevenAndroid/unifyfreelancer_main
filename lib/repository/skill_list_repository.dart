import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/model_skill_list_response.dart';
import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelSkillListResponse> skillListRepo() async {
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.skillList),
        headers: await getAuthHeader());

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelSkillListResponse.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelSkillListResponse(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } on SocketException catch (e) {
    return ModelSkillListResponse(
        message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelSkillListResponse(
        message: e.toString(), status: false, data: null);
  }
}
