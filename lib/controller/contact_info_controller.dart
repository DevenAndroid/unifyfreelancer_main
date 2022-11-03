import 'package:get/get.dart';

import '../models/model_close_account_reason_list.dart';
import '../models/model_timezone_list.dart';
import '../repository/close_account_reason_list_repository.dart';
import '../repository/timezone_list_repository.dart';
import '../utils/api_contant.dart';

class ContactInfoController extends GetxController{

  Rx<RxStatus> statusOfReason = RxStatus.empty().obs;

  ModelCloseAccountReasonList reasons = ModelCloseAccountReasonList();
  ModelTimeZone timezoneList = ModelTimeZone();

  @override
  void onInit() {
    super.onInit();
    getData();
    getTimezoneList();
  }


  getData(
      ){
    closeAccountReasonListRepo().then((value) {
      reasons = value;
      print(value.status);
      if(value.status == true){
        statusOfReason.value = RxStatus.success();
      }
      else{
        statusOfReason.value = RxStatus.error();
      }
      // showToast(value.message.toString());
    });
  }

  getTimezoneList(){
    timezoneListRepo().then((value) {
      timezoneList = value;
      if(value.status==true){
      }

    });
  }

}