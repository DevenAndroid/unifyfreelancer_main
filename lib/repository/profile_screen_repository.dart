import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';
import '../models/model_freelancer_profile.dart';
import '../utils/api_contant.dart';

Future<ModelFreelancerProfile> freelancerProfileRepo() async {
  try {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer ${pref.getString("cookie")}"

    };

    http.Response response = await http
        .get(Uri.parse(ApiUrls.getFreelancerProfile), headers: headers);

    if (response.statusCode == 200) {
      return ModelFreelancerProfile.fromJson(jsonDecode(response.body));
    } else {
      return ModelFreelancerProfile(
          data: null,
          message: jsonDecode(response.body)["message"],
          status: false);
    }
  } on SocketException catch (e) {
    return ModelFreelancerProfile(
        data: null, message: "No Internet Access", status: false);
  } catch (e) {
    return ModelFreelancerProfile(
        data: null, message: e.toString(), status: false);
  }
}
