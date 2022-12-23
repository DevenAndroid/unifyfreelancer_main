import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:unifyfreelancer/utils/api_contant.dart';
import '../../models/proposal_screen_model.dart';

Future<ModelProposal> allProposalRepo() async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.allProposal), headers: await getAuthHeader());
    print("Proposal List"+response.body);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelProposal.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode == 400){
      return ModelProposal(message: "No submit proposals", status: false, data: null);
    }
    else {
      print(jsonDecode(response.body));
      return ModelProposal(message: jsonDecode(response.body)["message"], status: false,data: null );
    }
  } on SocketException catch (e) {
    return ModelProposal(message: "No Internet Access", status: false,data: null);
  } catch (e) {
    return ModelProposal(message: e.toString(), status: false,data: null);
  }
}
