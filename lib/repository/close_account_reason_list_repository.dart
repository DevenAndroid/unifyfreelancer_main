import 'dart:convert';
import 'dart:io';

import '../models/model_close_account_reason_list.dart';
import 'package:http/http.dart' as http;

import '../utils/api_contant.dart';

Future<ModelCloseAccountReasonList> closeAccountReasonListRepo() async {
  try {
    final response = await http.get(Uri.parse(ApiUrls.closeAccountReasonList),
        headers: await getAuthHeader());
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelCloseAccountReasonList.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelCloseAccountReasonList(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  }
  on SocketException catch (e) {
    return ModelCloseAccountReasonList(
        message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelCloseAccountReasonList(message: e.toString(), status: false, data: null);
  }
}
