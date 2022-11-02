import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/model_timezone_list.dart';
import '../utils/api_contant.dart';

Future<ModelTimeZone> timezoneListRepo() async {
  try {
    final response = await http.get(
        Uri.parse(ApiUrls.timezoneList),
        headers: await getAuthHeader()
    );
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelTimeZone.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelTimeZone(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  }
  on SocketException catch (e) {
    return ModelTimeZone(
        message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelTimeZone(message: e.toString(), status: false, data: null);
  }
}
