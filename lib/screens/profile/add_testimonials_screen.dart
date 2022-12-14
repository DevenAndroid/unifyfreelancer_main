import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../controller/profie_screen_controller.dart';
import '../../repository/edit_testimonial_info_repository.dart';
import '../../resources/app_theme.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class AddTestimonialsScreen extends StatefulWidget {
  const AddTestimonialsScreen({Key? key}) : super(key: key);

  @override
  State<AddTestimonialsScreen> createState() => _AddTestimonialsScreenState();
}

class _AddTestimonialsScreenState extends State<AddTestimonialsScreen> {

  final controller = Get.put(ProfileScreenController());
  final _formKey = GlobalKey<FormState>();

  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  // TextEditingController _linkedinController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Add Testimonials",
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
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "First Name",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: _fNameController,
                  obSecure: false.obs,
                  keyboardType: TextInputType.text,
                  hintText: "Enter First Name".obs,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: 'First name is required')]),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Last Name",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: _lNameController,
                  obSecure: false.obs,
                  keyboardType: TextInputType.text,
                  hintText: "Enter Last Name".obs,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: 'Last name is required')]),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Business email address",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: _emailController,
                  obSecure: false.obs,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter Business Email".obs,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: 'Email is required')]),
                ),
               /* SizedBox(
                  height: 15,
                ),
                Text(
                  "Client's LinkedIn Profile",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: _linkedinController,
                  obSecure: false.obs,
                  keyboardType: TextInputType.url,
                  hintText: "http://".obs,
                  // validator: MultiValidator(
                  //     [RequiredValidator(errorText: 'Linkedin Url is required')]),
                ),*/
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Client's title (Optional)",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: _titleController,
                  obSecure: false.obs,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Degree (Optional)".obs,

                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Project Type (Optional)",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                    controller: _typeController,
                    obSecure: false.obs,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Degree (Optional)".obs,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: 'Type is required')]),),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Description (Optional)",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                    controller: _descriptionController,
                    obSecure: false.obs,
                    keyboardType: TextInputType.text,
                    hintText: "Description".obs,
                    isMulti: true,
                  validator: MultiValidator(
                      [RequiredValidator(errorText: 'Description is required')]),),
                SizedBox(
                  height: 25,
                ),
                CustomOutlineButton(
                  title: 'Request Testimonial',
                  backgroundColor: AppTheme.primaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      editTestimonialInfoRepo(
                             first_name:  _fNameController.text.trim(),
                            last_name:   _lNameController.text.trim(),
                             email:  _emailController.text.trim(),
                              // _linkedinController.text.trim(),
                            title:   _titleController.text.trim(),
                             type:  _typeController.text.trim(),
                            description:   _descriptionController.text.trim(),
                             context:  context)
                          .then((value) {
                        if (value.status == true) {
                          controller.getData();
                          Get.back();

                        }

                        showToast(value.message.toString());
                      });
                    }
                  },
                  textColor: AppTheme.whiteColor,
                  expandedValue: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
