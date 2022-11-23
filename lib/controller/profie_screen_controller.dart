import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/model_countrylist.dart';
import '../models/model_freelancer_profile.dart';
import '../models/model_language_list.dart';
import '../repository/languages_list_repository.dart';
import '../repository/profile_screen_repository.dart';

class ProfileScreenController extends GetxController {
  RxString timeValue = "".obs;

  Rx<ModelFreelancerProfile> model = ModelFreelancerProfile().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;

  ModelLanguageList languages = ModelLanguageList();


  final PageController pageController = PageController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  RxDouble currentIndex = 1.0.obs;
  Rx<ModelCountryList> countryList = ModelCountryList().obs;
  RxList searchList1 = <String>[].obs;
  RxBool acceptTermsOrPrivacy = false.obs;

  nextPage(){
    pageController.nextPage(
        duration: Duration(milliseconds: 800), curve: Curves.linear);
  }
  previousPage(){
    pageController.previousPage(
        duration: Duration(milliseconds: 800), curve: Curves.linear);
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    getLanguageData();
  }
  getData() {
    // status.value = RxStatus.empty();
    freelancerProfileRepo().then((value) {
      log("Profile Data......  "+jsonEncode(value));
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
        titleController.text = value.data!.basicInfo!.occuption.toString();
        descriptionController.text = value.data!.basicInfo!.description.toString();
      }
      else{
        status.value = RxStatus.error();
      }
    });
  }

  getLanguageData() {
    languagesListRepo().then((value) {
      languages = value;
      if (value.status == true) {
        print(languages);
      }
    });
  }
}
