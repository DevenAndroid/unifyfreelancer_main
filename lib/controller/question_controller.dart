import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/model_countrylist.dart';
import '../repository/countrylist_repository.dart';

class QuestionController extends GetxController{

  final PageController pageController = PageController();
  final TextEditingController textEditingController = TextEditingController();
  RxDouble currentIndex = 1.0.obs;


  Rx<ModelCountryList> countryList = ModelCountryList().obs;
  RxList searchList1 = <String>[].obs;

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
    pageController.addListener(() {
      currentIndex.value = pageController.page! + 1;
    });

    countryListRepo().then((value) {
      countryList.value = value;
    }
    );
  }

}