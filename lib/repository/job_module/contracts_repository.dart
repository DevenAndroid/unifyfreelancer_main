import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/utils/api_contant.dart';
import '../../models/model_contracts.dart';

Future<ModelContracts> contractsRepo() async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.contracts),
        headers: await getAuthHeader());
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelContracts.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelContracts(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } on SocketException {
    return ModelContracts(
        message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelContracts(message: e.toString(), status: false, data: null);
  }
}
