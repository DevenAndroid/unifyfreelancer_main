import 'package:get/get.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';


import '../models/model_dislike_reasons.dart';
import '../models/model_job_list.dart';
import '../repository/job_module/best_match_jobs_list_repository.dart';
import '../repository/job_module/dislike_reasons_repository.dart';
import '../repository/job_module/my_feed_job_list_repository.dart';
import '../repository/job_module/recent_jobs_list_repository.dart';

class JobListController extends GetxController {
  Rx<ModelJobsList> modelJobList = ModelJobsList().obs;
  Rx<ModelJobsList> modeRecentJobList = ModelJobsList().obs;
  Rx<ModelJobsList> modelBestJobList = ModelJobsList().obs;
  Rx<ModelDislikeReasons> dislikeReasons = ModelDislikeReasons().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;
  Rx<RxStatus> status2 = RxStatus.empty().obs;
  Rx<RxStatus> status3 = RxStatus.empty().obs;


  getDislikeReasons(){
    dislikeReasonsRepo().then((value) {
      print(value.data);
      dislikeReasons.value = value;
      if(value.status = true){}
    });
  }

  getData() {
    jobListRepo(15).then((value) {
      modelJobList.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
      } else {
        status.value = RxStatus.error();
      }
    });
  }

  getDataRecentJob() {
    recentJobsListRepo().then((value) {
      modeRecentJobList.value = value;
      if (value.status == true) {
        status2.value = RxStatus.success();
      } else {
        status2.value = RxStatus.error();
      }

    });
  }

  getDataBestJob() {
    bestMatchJobsListRepo().then((value) {
      modelBestJobList.value = value;
      if (value.status == true) {
        status3.value = RxStatus.success();
      } else {
        status3.value = RxStatus.error();
        showToast(value.message.toString());
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    getDataRecentJob();
    getDataBestJob();
    getDislikeReasons();
  }
}
