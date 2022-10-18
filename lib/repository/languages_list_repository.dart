import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/model_language_list.dart';
import '../utils/api_contant.dart';

Future<ModelLanguageList> languagesListRepo() async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.languagesList),
        headers: await getAuthHeader());

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelLanguageList.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelLanguageList(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } on SocketException catch (e) {
    return ModelLanguageList(
        message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelLanguageList(
        message: e.toString(), status: false, data: null);
  }
}
