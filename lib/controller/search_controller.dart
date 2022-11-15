import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/model_dislike_reasons.dart';
import '../models/model_job_list.dart';
import '../repository/job_module/dislike_reasons_repository.dart';
import '../repository/job_module/search_jobs_repository.dart';


class SearchJobListController extends GetxController {
  Rx<ModelJobsList> model = ModelJobsList().obs;
  Rx<ModelDislikeReasons> dislikeReasons = ModelDislikeReasons().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;
  Rx<RxStatus> dislikeReasonStatus = RxStatus.empty().obs;

  final TextEditingController searchController = TextEditingController();

  getData() {
    status.value = RxStatus.loading();
    searchJobListRepo(searchController.text.trim()).then((value) {
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
      } else {
        status.value = RxStatus.error();
      }
    });
  }

  getDislikeReasons(){
    dislikeReasonsRepo().then((value) {
      print(value.data);
      dislikeReasons.value = value;
      if(value.status = true){
        dislikeReasonStatus.value = RxStatus.success();
      }
      else
        {
          dislikeReasonStatus.value = RxStatus.error();
        }
    });
  }

  @override
  void onInit() {
    super.onInit();
    searchController.text = Get.arguments[0];
    getData();
    getDislikeReasons();

  }
}
