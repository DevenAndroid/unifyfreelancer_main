
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../models/Model_common_response.dart';
import '../../models/proposals/model_decline_reason_list.dart';
import '../../resources/helper.dart';
import '../../utils/api_contant.dart';


Future<ModelDeclineReasonList> declineReasonListRepo(type) async {

  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.declineReasonList+"${type.toString()}"),
        headers: await getAuthHeader() );

    if (response.statusCode == 200) {

      print(jsonDecode(response.body));
      return ModelDeclineReasonList.fromJson(jsonDecode(response.body));
    } else {

      print(jsonDecode(response.body));
      return ModelDeclineReasonList(
          message: jsonDecode(response.body)["message"], status: false);
    }
  } on SocketException catch (e) {

    return ModelDeclineReasonList(message: "No Internet Access", status: false);
  } catch (e) {

    return ModelDeclineReasonList(message: e.toString(), status: false);
  }
}
