import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/model_category_list.dart';
import '../models/model_dislike_reasons.dart';
import '../models/model_job_list.dart';
import '../models/model_skill_list_response.dart';
import '../repository/category_list_repository.dart';
import '../repository/job_module/dislike_reasons_repository.dart';
import '../repository/job_module/search_jobs_repository.dart';
import '../repository/skill_list_repository.dart';

class SearchJobListController extends GetxController {
  Rx<ModelJobsList> model = ModelJobsList().obs;
  RxList<JobListData> modelForPagination = <JobListData>[].obs;
  RxBool loading = false.obs;
  RxBool loadMore = false.obs;
  RxInt page = 1.obs;
  RxInt pagination = 20.obs;

  //filters
  RxString jobType = "".obs;
  RxString projectDuration = "".obs;
  RxString budgetType = "".obs;
  RxString englishLevel = "".obs;
  List catId = <String>[];
 // RangeValues currentRangeValues =  const RangeValues(3, 10000);
  TextEditingController firstRangeController = TextEditingController();
  TextEditingController secondRangeController = TextEditingController();

  Rx<ModelDislikeReasons> dislikeReasons = ModelDislikeReasons().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;
  Rx<RxStatus> statusSkills = RxStatus.empty().obs;
  Rx<RxStatus> dislikeReasonStatus = RxStatus.empty().obs;

  //category
  Rx<ModelCategoryList> modelCategory = ModelCategoryList().obs;
  Rx<RxStatus> statusCategory = RxStatus.empty().obs;

  final TextEditingController searchController = TextEditingController();

  getData() {
    String catIdForSend = "";
    String skillIdForSend = "";
    if (loading.value == false) {
      if(catId.isNotEmpty){
        for(var item in catId){
          catIdForSend = "$catIdForSend$item,";
        }
      }
      if(selectedList.isNotEmpty){
        for(var item in selectedList){
          skillIdForSend = "$skillIdForSend${item.id.toString()},";
        }
      }
      loading.value = true;
      searchJobListRepo(
          search: searchController.text.trim(),
              pagination: pagination.value,
              page: page.value,
              type: jobType.value,
              project_duration:projectDuration.value,
              budget_type: budgetType.value,
          min_price: firstRangeController.text,
          max_price: secondRangeController.text,
        english_level: englishLevel.value,
        project_category:catIdForSend.toString(),
          skills: skillIdForSend.toString()
      )
          .then((value) {
        log("Posted Jobs Data ......${jsonEncode(value)}");
        if (kDebugMode) {
          print(searchController.text.trim());
        }
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
      if (kDebugMode) {
        print(value.data);
      }
      dislikeReasons.value = value;
      if (value.status = true) {
        dislikeReasonStatus.value = RxStatus.success();
      } else {
        dislikeReasonStatus.value = RxStatus.error();
      }
    });
  }

  getCategoryList(){
    categoryListRepo().then((value) {
      modelCategory.value = value;
      if (value.status == true) {
        statusCategory.value = RxStatus.success();

      }
      else {
        statusCategory.value = RxStatus.error();
      }
    });
  }

  // skills list
  ModelSkillListResponse skillList = ModelSkillListResponse();
  RxList<AllData> selectedList = <AllData>[].obs;
  RxList<AllData> tempList = <AllData>[].obs;
  Rx<RxStatus> skillStatus = RxStatus.empty().obs;

  TextEditingController textEditingController = TextEditingController();

  RxBool showSkillsList = false.obs;
  getSkills(){
    skillListRepo().then((value) {
      skillList = value;
      if (value.status == true) {
     /*   for(var item in controller.model.value.data!.skills!){
          log(item.skillId.toString());
          for(var i = 0; i<skillList.data!.length; i++){
            if(item.skillId.toString() == skillList.data![i].id.toString()){
              skillList.data![i].isSelected!.value = true;
              selectedList.add(skillList.data![i]);
            }
          }
        }*/
        statusSkills.value = RxStatus.success();
      } else {
        statusSkills.value = RxStatus.error();
      }
    });
  }


  @override
  void onInit() {
    super.onInit();
   searchController.text = Get.arguments[0];
   //  firstRangeController.text = 3.00.toString();
    // secondRangeController.text = currentRangeValues.end.toString();
    getData();
    getDislikeReasons();
    getCategoryList();
    getSkills();
  }
}
