import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/model_edit_designation_info.dart';
import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelEditDesignationInfo> editDesignationInfoRepo(title,description,context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  map['title'] = title;
  map['description'] = description;
  print(map);
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.editDesignationInfo),
        headers: await getAuthHeader(),body: jsonEncode(map) );

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      return ModelEditDesignationInfo.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      return ModelEditDesignationInfo(
          message: jsonDecode(response.body)["message"], status: false);
    }
  } on SocketException catch (e) {
    Helpers.hideLoader(loader);
    return ModelEditDesignationInfo(
        message: "No Internet Access", status: false);
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelEditDesignationInfo(message: e.toString(), status: false);
  }
}
