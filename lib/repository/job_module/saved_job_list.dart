import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../models/model_job_list.dart';
import '../../utils/api_contant.dart';

Future<ModelJobsList> savedJobListRepo() async {
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.savedJobList),
        headers: await getAuthHeader());

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelJobsList.fromJson(jsonDecode(response.body));
    }
    else if (response.statusCode == 400) {
      print(jsonDecode(response.body));
      return ModelJobsList.fromJson(jsonDecode(response.body));
    }
    else {
      print(jsonDecode(response.body));
      return ModelJobsList(message: jsonDecode(response.body)["message"], status: false, data: null);
    }
  }
  on SocketException catch (e) {
    return ModelJobsList(message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelJobsList(message: e.toString(), status: false, data: null);
  }
}
