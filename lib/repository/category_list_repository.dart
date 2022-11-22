import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../models/model_category_list.dart';

Future<ModelCategoryList> categoryListRepo() async {
  try{

    http.Response response = await http.get(Uri.parse(ApiUrls.categoryList),headers: await getAuthHeader());
    print(response.body);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelCategoryList.fromJson(jsonDecode(response.body));

    } else {
      print(jsonDecode(response.body));
      return ModelCategoryList(message: jsonDecode(response.body)["message"], status: false,data: null);
    }
  } on SocketException{

    return ModelCategoryList(message: "No Internet Access", status: false,data: null);
  } catch (e) {

    return ModelCategoryList(message: e.toString(), status: false,data: null);
  }
}