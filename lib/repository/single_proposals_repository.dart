
import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;

import '../models/Model_common_response.dart';

import '../models/model_single_proposal.dart';
import '../utils/api_contant.dart';



Future<SingleProposal> singleProposalDetailsRepo(id) async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.singleProposalDetails+"${id}/offer"),
        headers: await getAuthHeader() );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return SingleProposal.fromJson(jsonDecode(response.body));

    } else {
      print(jsonDecode(response.body));
      return SingleProposal(message: jsonDecode(response.body)["message"], status: false,data: null);
    }
  } on SocketException catch (e) {

    return SingleProposal(message: "No Internet Access", status: false,data: null);
  } catch (e) {
    return SingleProposal(message: e.toString(), status: false,data: null);
  }
}