
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../../models/Model_common_response.dart';
import '../../resources/helper.dart';
import '../../utils/api_contant.dart';


Future<ModelCommonResponse> sendProposalRepo({
  required mapData,
  required fieldName1,
  required File file1,
  required context,
})
async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try {
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.sendProposal));

    request.headers.addAll(await getAuthHeader());

    request.fields.addAll(mapData);

    if(file1.path != "") request.files.add(await multipartFile(fieldName1, file1));

    log(request.fields.toString());
    log(request.files.toString());

    final response = await request.send();
    Helpers.hideLoader(loader);
    if(response.statusCode == 200) {
      Helpers.hideLoader(loader);
      // log(jsonDecode(response.body)["message"]);
      return ModelCommonResponse.fromJson(jsonDecode(await response.stream.bytesToString()));
    }
    else {
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(jsonDecode(await response.stream.bytesToString()));
    }
  } on SocketException catch(e){
    Helpers.hideLoader(loader);
    return ModelCommonResponse(
        message: "No Internet Access",
        status: false
    );
  } catch (e){
    Helpers.hideLoader(loader);
    return ModelCommonResponse(
        message: e.toString(),
        status: false
    );
  }
}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? 'file',
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}