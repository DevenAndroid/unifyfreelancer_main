import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../models/contracts/model_for_timesheet.dart';
import '../../utils/api_contant.dart';

Future<ModelTimesheet> contractTimesheetRepo({required contract_id, start_date, end_date}) async {
  Map map = <String, dynamic>{};
  map["contract_id"] = contract_id;
  if(start_date != ""){
    map["start_date"] = start_date;
  }
  if(end_date != ""){
    map["end_date"] = end_date;
  }

  try {

    http.Response response = await http.post(Uri.parse(ApiUrls.contractTimesheet), headers: await getAuthHeader(), body: jsonEncode(map));
   log(response.body);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelTimesheet.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelTimesheet(message: jsonDecode(response.body)["message"], status: false, data: null);
    }
  } on SocketException catch (e) {
    return ModelTimesheet(
        message: "No Internet Access", status: false, data: null);
  } catch (e) {
    return ModelTimesheet(message: e.toString(), status: false, data: null);
  }
}
