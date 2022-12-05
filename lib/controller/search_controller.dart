import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/model_dislike_reasons.dart';
import '../models/model_job_list.dart';
import '../repository/job_module/dislike_reasons_repository.dart';
import '../repository/job_module/search_jobs_repository.dart';

class SearchJobListController extends GetxController {
  Rx<ModelJobsList> model = ModelJobsList().obs;
  RxList<JobListData> modelForPagination = <JobListData>[].obs;
  RxBool loading = false.obs;
  RxBool loadMore = false.obs;
  RxInt page = 1.obs;
  RxInt pagination = 20.obs;

  Rx<ModelDislikeReasons> dislikeReasons = ModelDislikeReasons().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;
  Rx<RxStatus> dislikeReasonStatus = RxStatus.empty().obs;

  final TextEditingController searchController = TextEditingController();

  getData() {
    if (loading.value == false) {
      loading.value = true;
      searchJobListRepo(
          search: searchController.text.trim(),
              pagination: pagination.value,
              page: page.value)
          .then((value) {
        log("Posted Jobs Data ......${jsonEncode(value)}");
        print(searchController.text.trim());
        model.value = value;
        loading.value = false;
        if (value.status == true) {
          status.value = RxStatus.success();
        } else {
          status.value = RxStatus.error();
        }
        loadMore.value = value.link!.next ?? false;
        modelForPagination.addAll(model.value.data!);
      });
    }
  }

  getDislikeReasons() {
    dislikeReasonsRepo().then((value) {
      print(value.data);
      dislikeReasons.value = value;
      if (value.status = true) {
        dislikeReasonStatus.value = RxStatus.success();
      } else {
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
