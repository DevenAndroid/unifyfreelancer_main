import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/proposals/model_invite.dart';
import '../../utils/api_contant.dart';



Future<ModelInvite> inviteRepo(id) async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.singleProposalDetails+"${id}/invite"),
        headers: await getAuthHeader() );
    print(ApiUrls.singleProposalDetails+"${id}/invite");

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelInvite.fromJson(jsonDecode(response.body));

    } else {
      print(jsonDecode(response.body));
      return ModelInvite(message: jsonDecode(response.body)["message"], status: false,data: null);
    }
  } on SocketException catch (e) {

    return ModelInvite(message: "No Internet Access", status: false,data: null);
  } catch (e) {
    return ModelInvite(message: e.toString(), status: false,data: null);
  }
}