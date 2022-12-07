import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import '../../models/model_single_job.dart';
import '../../utils/api_contant.dart';

Future<ModelSingleJob> singleJobRepo(jobId)
async {
 /* Map map = <String, dynamic>{};
  map["job_id"] = job_id;
  print(map);*/

  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.singleJob +"/$jobId"),
        headers: await getAuthHeader()  );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelSingleJob.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelSingleJob(
          message: jsonDecode(response.body)["message"], status: false);
    }
  } on SocketException {
    return ModelSingleJob(
        message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelSingleJob(message: e.toString(), status: false, data: null);
  }
}
