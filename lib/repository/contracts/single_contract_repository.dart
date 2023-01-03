import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../../models/contracts/model_single_contract.dart';

Future<ModelSingleContract> singleContract(id) async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.singleContract+id),
      headers: await getAuthHeader(),
    );
print(Uri.parse(ApiUrls.singleContract+id));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      return ModelSingleContract.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      return ModelSingleContract(
          message: jsonDecode(response.body)["message"], status: false,data: null);
    }
  } on SocketException catch (e) {
    return ModelSingleContract(message: "No Internet Access", status: false,data: null);
  } catch (e) {
    return ModelSingleContract(message: e.toString(), status: false,data: null);
  }
}
