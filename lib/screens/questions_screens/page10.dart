import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/controller/profie_screen_controller.dart';

import '../../models/model_category_list.dart';
import '../../repository/add_category_repository.dart';
import '../../repository/category_list_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/progress_indicator.dart';

class Page10 extends StatefulWidget {
  Page10({Key? key}) : super(key: key);

  @override
  State<Page10> createState() => _Page10State();
}

class _Page10State extends State<Page10> {
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    getData();

  }

  Rx<ModelCategoryList> model = ModelCategoryList().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;
  RxInt id = 0.obs;



// Service provider screen
  getData() {
    categoryListRepo().then((value) {
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
        for(var item in model.value.data!){
          if(item.name!.toLowerCase() == controller.model.value.data!.basicInfo!.category!.toLowerCase()){
            id.value = item.id!;
            controller.serviceController.text = item.name.toString();
          }
        }
      }
      else {
        status.value = RxStatus.error();
      }
    });
  }

  final controller = Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return status.value.isSuccess ? Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(12),
            height: AddSize.screenHeight,
            width: AddSize.screenWidth,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AddSize.size10,
                  ),
                  Text(
                    "What are the main services you offer?",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkBlueText,
                        fontSize: AddSize.font20),
                  ),
                  SizedBox(
                    height: AddSize.size15,
                  ),
                  Text(
                    "Choose at least 1 service that best describes the type of work you do. this helps us match you with clients who need your unique expertise.",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font12),
                  ),
                  SizedBox(
                    height: AddSize.size20,
                  ),
                  CustomTextField(
                    onTap: () {
                      services();
                    },
                    controller: controller.serviceController,
                    readOnly: true,
                    obSecure: false.obs,
                    hintText: "Search for a service".obs,
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: 'Please select a service'),
                    ]),
                  ),
                  SizedBox(
                    height: AddSize.size20,
                  ),
                  Text(
                    "Suggested services",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkBlueText,
                        fontSize: AddSize.font16),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            model.value.data![index].name.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textColor,
                                fontSize: AddSize.font12),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ) : status.value.isError ? CommonErrorWidget(
          errorText: model.value.message.toString(), onTap: () {
          getData();
        },) : CommonProgressIndicator();
      }),
      bottomNavigationBar: Obx(() {
        return status.value.isSuccess ?
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomOutlineButton(
                  title: 'Back',
                  backgroundColor: AppTheme.whiteColor,
                  onPressed: () {
                   controller.previousPage();
                  },
                  textColor: AppTheme.primaryColor,
                  expandedValue: false,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomOutlineButton(
                  title: 'Next',
                  backgroundColor: AppTheme.primaryColor,
                  onPressed: () {

                    if (_formKey.currentState!.validate()) {
                      addCategoryRepo(category_id: id.value, context: context)
                          .then((value) {
                        if (value.status == true) {
                          controller.nextPage();
                        }
                      //  showToast(value.message.toString());
                      }
                      );
                    }
                  },
                  textColor: AppTheme.whiteColor,
                  expandedValue: false,
                ),
              ),
            ),
          ],
        ) :
        SizedBox();
      }),
    );
  }

  void services() {
    return showFilterButtonSheet(
        context: context,
        titleText: "Select a service",
        widgets: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: AppTheme.pinkText.withOpacity(.49),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.value.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        controller.serviceController.text = model.value.data![index].name.toString();
                        id.value = model.value.data![index].id!;
                        print(id.value.toString());
                      },
                      child: Text(
                        model.value.data![index].name.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkBlueText,
                            fontSize: AddSize.font16),
                      ),
                    ),
                  );
                })
          ],
        ));
  }
}
