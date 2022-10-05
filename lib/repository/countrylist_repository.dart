import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/utils/api_contant.dart';
import '../models/model_countrylist.dart';

final headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
  HttpHeaders.acceptHeader: 'application/json',
};

Future<ModelCountryList> countryListRepo() async {
  final response = await http.get(Uri.parse(ApiUrls.countryList),
  headers: headers
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(jsonDecode(response.body));
    return ModelCountryList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(jsonDecode(response.body));
    throw Exception(response.body);
  }
}