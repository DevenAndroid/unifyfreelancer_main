import 'package:get/get.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../models/Reports/model_overview.dart';
import '../repository/reports/overview.dart';

class ReportsController extends GetxController{

  Rx<RxStatus> overviewStatus = RxStatus.empty().obs;
  Rx<ModelOverview> modelOverview = ModelOverview().obs;

  getData(){
    overviewRepo().then((value) {
      modelOverview.value = value;
      if(value.status == true){
        overviewStatus.value = RxStatus.success();
      }
      else{
        overviewStatus.value = RxStatus.error();
      }
      showToast(value.message.toString());
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
}