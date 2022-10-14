import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../repository/add_portfolio_repository.dart';
import '../../resources/app_theme.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class AddPortFolioScreen extends StatefulWidget {
  const AddPortFolioScreen({Key? key}) : super(key: key);

  @override
  State<AddPortFolioScreen> createState() => _AddPortFolioScreenState();
}

class _AddPortFolioScreenState extends State<AddPortFolioScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  File imageFileToPick = File("");

  pickImageFromDevice({required imageSource}) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      imageFileToPick = File(image.path);
      setState(() {});
    } catch (e) {
      throw Exception(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Add Portfolio",
          // onPressedForLeading:,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                    controller: _nameController,
                    obSecure: false.obs,
                    keyboardType: TextInputType.text,
                    hintText: "Title".obs,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: 'Title is required'),
                  ]),),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: _descriptionController,
                    obSecure: false.obs,
                    keyboardType: TextInputType.text,
                    hintText: "Description".obs,
                    isMulti: true,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: 'Description is required'),
                  ]),),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () =>
                      pickImageFromDevice(imageSource: ImageSource.gallery),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: AppTheme.primaryColor.withOpacity(.15),
                            width: 1.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icon/script.svg",
                                height: 15,
                                width: 15,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Attach Files",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppTheme.pinkText,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            "Choose File",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.whiteColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (imageFileToPick.path != "")
                  Image.file(
                    imageFileToPick,
                    height: 100,
                    width: 100,
                  )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOutlineButton(
                title: 'Select Template',
                backgroundColor: AppTheme.whiteColor,
                onPressed: () {
                  pickImageFromDevice(imageSource: ImageSource.gallery);
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
                title: 'Save',
                backgroundColor: AppTheme.primaryColor,
                onPressed: (){
                  if(_formKey.currentState!.validate() && imageFileToPick.path != ""){
                    Map<String,String> map = {};
                    map["title"] = _nameController.text.trim();
                    map["description"] = _descriptionController.text.trim();
                    editPortfolioInfoRepo(
                      mapData: map,
                      fieldName1: "image",
                      file1: imageFileToPick,
                      context: context,).then((value) {
                        if(value.status == true){
                          Get.back();
                        }
                        showToast(value.message.toString());
                    });
                  }
                  else{
                    showToast("Please add a image");
                  }
                },
                textColor: AppTheme.whiteColor,
                expandedValue: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
