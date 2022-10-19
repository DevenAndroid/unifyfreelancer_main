import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/model_degree_list.dart';
import '../utils/api_contant.dart';

Future<ModelDegreeList> degreeListRepo() async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.degreeList),
        headers: await getAuthHeader());

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelDegreeList.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelDegreeList(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } on SocketException catch (e) {
    return ModelDegreeList(
        message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelDegreeList(
        message: e.toString(), status: false, data: null);
  }
}
