import 'dart:convert';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../models/model_job_list.dart';
import '../../utils/api_contant.dart';

Future<ModelJobsList> searchJobListRepo({search,page,pagination,type,project_duration,budget_type,min_price,max_price,english_level,project_category,skills}) async {
  Map map = <String,dynamic>{};
  map['search'] = search;
  map['page'] = page;
  map['pagination'] = pagination;
  map['min_price'] = min_price;
  map['max_price'] = max_price;
  if(type != ""){
    map['type'] = type;
  }
  if(project_duration != ""){
    map['project_duration'] = project_duration;
  }
  if(budget_type != ""){
    map['budget_type'] = budget_type;
  }
  if(english_level != ""){
    map['english_level'] = english_level;
  }
  if(project_category != ""){
    map['project_category'] = project_category;
  }
  if(skills != ""){
    map['skills'] = skills;
  }
  if (kDebugMode) {
    print("Searching value :::::$map");
  }
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.jobsList),
      headers: await getAuthHeader(),body: jsonEncode(map));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      return ModelJobsList.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      return ModelJobsList(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } on SocketException {
    return ModelJobsList(
        message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelJobsList(
        message: e.toString(), status: false, data: null);
  }
}
