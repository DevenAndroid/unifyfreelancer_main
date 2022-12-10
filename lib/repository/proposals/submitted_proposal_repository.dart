import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/proposals/model_submitted_proposal.dart';
import '../../utils/api_contant.dart';



Future<ModelSubmittedProposal> submittedRepo(id) async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.singleProposalDetails+"${id}/submit"),
        headers: await getAuthHeader() );
    print(ApiUrls.singleProposalDetails+"${id}/submit");

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelSubmittedProposal.fromJson(jsonDecode(response.body));

    } else {
      print(jsonDecode(response.body));
      return ModelSubmittedProposal(message: jsonDecode(response.body)["message"], status: false,data: null);
    }
  } on SocketException catch (e) {

    return ModelSubmittedProposal(message: "No Internet Access", status: false,data: null);
  } catch (e) {
    return ModelSubmittedProposal(message: e.toString(), status: false,data: null);
  }
}