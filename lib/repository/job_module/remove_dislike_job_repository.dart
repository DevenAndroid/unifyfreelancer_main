/*
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../../models/Model_common_response.dart';
import '../../resources/helper.dart';

Future<ModelCommonResponse> removeDislikeJobRepo({job_id,reason_id,context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  Map map =<String,dynamic>{};
  map["job_id"] = job_id;
  map["reason_id"] = reason_id;
  print(map);

  try{
    http.Response response = await http.post(Uri.parse(ApiUrls.removeDislikeJob),headers: await getAuthHeader(), body: jsonEncode(map));


    if(response.statusCode == 200){
      Helpers.hideLoader(context);
      print(jsonDecode(response.body));
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    }
  }

}*/
