import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/model_hours_per_week.dart';
import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelHoursPerWeek> hoursPerWeekRepo(context) async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.hoursPerWeek),
        headers: await getAuthHeader());

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelHoursPerWeek.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelHoursPerWeek(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } on SocketException catch (e) {
    return ModelHoursPerWeek(
        message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelHoursPerWeek(message: e.toString(), status: false, data: null);
  }
}
