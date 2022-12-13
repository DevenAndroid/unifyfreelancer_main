import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/Model_common_response.dart';
import 'package:http/http.dart' as http;

import '../../resources/helper.dart';
import '../../utils/api_contant.dart';

Future<ModelCommonResponse> updateProposalRepo(proposal_id, bid_amount,
    milestone_type, milestone_data, project_duration, context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var map = <String, dynamic>{};
  map['proposal_id'] = proposal_id;

  if (milestone_type == "" || milestone_type == "single") {
    map['bid_amount'] = bid_amount;
  }

  if (milestone_type != "") {
    map['milestone_type'] = milestone_type;
  }
  if (milestone_type == "multiple") {
    map['milestone_data'] = milestone_data;
  }
  if (milestone_type != "") {
    map['project_duration'] = project_duration;
  }
  print(map);
  try {
    http.Response response = await http.post(Uri.parse(ApiUrls.updateProposal),
        headers: await getAuthHeader(), body: jsonEncode(map));
    print(response.body);

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
