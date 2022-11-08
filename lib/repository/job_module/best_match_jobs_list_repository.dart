import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import '../../models/model_job_list.dart';
import '../../utils/api_contant.dart';

Future<ModelJobsList> bestMatchJobsListRepo() async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.bestMatchJobsList),
        headers: await getAuthHeader());
    print("Best match api responseBest match api response ::::"+response.body);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelJobsList.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelJobsList(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } on SocketException catch (e) {
    return ModelJobsList(
        message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelJobsList(
        message: e.toString(), status: false, data: null);
  }
}
