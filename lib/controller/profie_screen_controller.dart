import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../models/model_category_list.dart';
import '../models/model_countrylist.dart';
import '../models/model_freelancer_profile.dart';
import '../models/model_language_list.dart';
import '../repository/category_list_repository.dart';
import '../repository/languages_list_repository.dart';
import '../repository/profile_screen_repository.dart';

class ProfileScreenController extends GetxController {
  RxString timeValue = "".obs;

  Rx<ModelFreelancerProfile> model = ModelFreelancerProfile().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;
  Rx<RxStatus> serviceStatus = RxStatus.empty().obs;

  ModelLanguageList languages = ModelLanguageList();


  final PageController pageController = PageController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  RxDouble currentIndex = 1.0.obs;
  Rx<ModelCountryList> countryList = ModelCountryList().obs;
  RxList searchList1 = <String>[].obs;
  RxString profileImage = "".obs;
  RxInt questionIndex2 = (-1).obs;
  RxInt questionIndex3 = (-1).obs;

  final priceController = TextEditingController();
  final countryController = TextEditingController();
  final phoneController = TextEditingController();
  final zipController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final designationController = TextEditingController();
  final designationDescriptionController = TextEditingController();
  final serviceController = TextEditingController();

//profile preview service list

  Rx<ModelCategoryList> modelOfService = ModelCategoryList().obs;


  getDataOfService() {
    categoryListRepo().then((value) {
      modelOfService.value = value;
      if (value.status == true) {
         serviceStatus.value = RxStatus.success();

        // for(var item in modelOfService.value.data!){
        //   if(item.name!.toLowerCase() == controller.model.value.data!.basicInfo!.category!.toLowerCase()){
        //     id.value = item.id!;
        //     controller.serviceController.text = item.name.toString();
        //   }
        }

      else {
        serviceStatus.value = RxStatus.error();
      }
    });
  }

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
    getDataOfService();
  }
  getData() {
    freelancerProfileRepo().then((value) async {
      log("Profile Data......  "+jsonEncode(value));
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
        titleController.text = value.data!.basicInfo!.occuption.toString();
        descriptionController.text = value.data!.basicInfo!.description.toString();
        priceController.text = value.data!.basicInfo!.amount.toString();
        countryController.text = value.data!.basicInfo!.country.toString();
        phoneController.text = value.data!.basicInfo!.phone.toString();
        zipController .text = value.data!.basicInfo!.zipCode.toString();
        addressController.text = value.data!.basicInfo!.address.toString();
        cityController .text = value.data!.basicInfo!.city.toString();
        profileImage.value = value.data!.basicInfo!.profileImage.toString();
        designationController.text =  value.data!.basicInfo!.occuption.toString();
        designationDescriptionController.text =  value.data!.basicInfo!.description.toString();
        serviceController.text =  value.data!.basicInfo!.category.toString();
        SharedPreferences pref = await SharedPreferences.getInstance();
        if(model.value.data!.basicInfo!.is_profile_complete == true  && pref.getBool('isProfileCompleted') == false){
          pref.setBool('isProfileCompleted',true);
          Get.offAllNamed(MyRouter.bottomNavbar);
        }

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
