import 'package:get/get.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../models/model_job_list.dart';
import '../repository/job_module/saved_job_list.dart';

class SavedJobController extends GetxController{
  Rx<RxStatus> status = RxStatus.empty().obs;
  Rx<ModelJobsList> model = ModelJobsList().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  getData(){
    savedJobListRepo().then((value) {
      model.value = value;
      if(value.status == true){
        status.value = RxStatus.success();
      }
      else{
        status.value = RxStatus.error();
      }

    });
  }
}