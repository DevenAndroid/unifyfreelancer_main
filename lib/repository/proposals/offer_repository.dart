
import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;



import '../../models/proposals/model_offer_proposal.dart';
import '../../utils/api_contant.dart';



Future<ModelOffer> offerRepo(id) async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.singleProposalDetails+"${id}/offer"),
        headers: await getAuthHeader() );
    print(ApiUrls.singleProposalDetails+"${id}/offer");

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelOffer.fromJson(jsonDecode(response.body));

    } else {
      print(jsonDecode(response.body));
      return ModelOffer(message: jsonDecode(response.body)["message"], status: false,data: null);
    }
  } on SocketException catch (e) {

    return ModelOffer(message: "No Internet Access", status: false,data: null);
  } catch (e) {
    return ModelOffer(message: e.toString(), status: false,data: null);
  }
}