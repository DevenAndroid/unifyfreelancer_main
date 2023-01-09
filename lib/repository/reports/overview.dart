import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../models/Reports/model_overview.dart';
import '../../utils/api_contant.dart';

Future<ModelOverview> overviewRepo() async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.overview), headers: await getAuthHeader());

    print(response.body);

    if (response.statusCode == 200) {
      return ModelOverview.fromJson(jsonDecode(response.body));
    } else {
      return ModelOverview(
        status: false,
          message: jsonDecode(response.body)["message"],
        data: null,
          );
    }
  } on SocketException {
    return ModelOverview(
         message: "No Internet Connection", status: false,data: null,);
  } catch (e) {
    return ModelOverview(
        message: e.toString(), status: false, data: null,);
  }
}
