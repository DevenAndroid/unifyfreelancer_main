import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../models/model_freelancer_profile.dart';
import '../utils/api_contant.dart';

Future<ModelFreelancerProfile> freelancerProfileRepo() async {

  SharedPreferences pref = await SharedPreferences.getInstance();
  final header =  {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}'
  };
  print(pref.getString("cookie")!.toString().replaceAll('\"', ''));
  try {
    http.Response response = await http.get(
        Uri.parse(ApiUrls.getFreelancerProfile),
        headers: header);

    if (response.statusCode == 200) {
      return ModelFreelancerProfile.fromJson(jsonDecode(response.body));
    } else {
      return ModelFreelancerProfile(
          data: null,
          message: jsonDecode(response.body)["message"],
          status: false);
    }
  } on SocketException catch (e) {
    return ModelFreelancerProfile(
        data: null, message: "No Internet Access", status: false);
  } catch (e) {
    return ModelFreelancerProfile(
        data: null, message: e.toString(), status: false);
  }
}
