import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unifyfreelancer/models/model_edit_certificate_info.dart';
import 'package:http/http.dart' as http;

import '../resources/helper.dart';
import '../utils/api_contant.dart';

Future<ModelEditCertificateInfo> editCertificateInfoRepo(name,description,context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  map['name'] = name;
  map['description'] = description;

  print(map);
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.editCertificateInfo),
        headers: await getAuthHeader(),body: jsonEncode(map) );

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      print(jsonDecode(response.body));
      return ModelEditCertificateInfo.fromJson(jsonDecode(response.body));

    } else {
      Helpers.hideLoader(loader);
      print(jsonDecode(response.body));
      return ModelEditCertificateInfo(message: jsonDecode(response.body)["message"], status: false);
    }
  } on SocketException catch (e) {
    Helpers.hideLoader(loader);
    return ModelEditCertificateInfo(message: "No Internet Access", status: false);
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelEditCertificateInfo(message: e.toString(), status: false);
  }
}