
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../models/Model_common_response.dart';
import '../../resources/helper.dart';
import '../../utils/api_contant.dart';


Future<ModelCommonResponse> inviteDeclineRepo({invitaion_id,reason,description, context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  map['invitaion_id'] = invitaion_id;
  map['reason'] = reason;
  map['id'] = description;

  print(map);
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.inviteDecline),
        headers: await getAuthHeader(), body: jsonEncode(map));

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      print(jsonDecode(response.body));
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      print(jsonDecode(response.body));
      return ModelCommonResponse(
          message: jsonDecode(response.body)["message"], status: false);
    }
  } on SocketException catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: e.toString(), status: false);
  }
}
