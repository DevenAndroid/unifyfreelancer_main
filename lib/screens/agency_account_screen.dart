import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/controller/profie_screen_controller.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../repository/additional_account_repository.dart';
import '../resources/app_theme.dart';
import '../utils/api_contant.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_textfield.dart';

class AgencyAccountScreen extends StatefulWidget {
  const AgencyAccountScreen({Key? key}) : super(key: key);

  @override
  State<AgencyAccountScreen> createState() => _AgencyAccountScreenState();
}

class _AgencyAccountScreenState extends State<AgencyAccountScreen> {

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ProfileScreenController());

  final TextEditingController _agencyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Agency",
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15,left: 10),
                  child: Text(
                    "Create Agency",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: AppTheme.textColor),
                  ),
                ),
                Divider(
                  color: AppTheme.pinkText.withOpacity(.29),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Agencies allow for multiple freelancers on a single team and often have business managers. Create an agency if you plan to work this way. ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppTheme.textColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Agency Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppTheme.textColor),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      CustomTextField(
                        controller: _agencyController,
                        obSecure: false.obs,
                        keyboardType: TextInputType.text,
                        hintText: "".obs,
                        validator: MultiValidator(
                            [RequiredValidator(errorText: 'Agency name is required')]),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CustomOutlineButton(
                              title: 'cancel',
                              backgroundColor: AppTheme.whiteColor,
                              onPressed: () => Get.back(),
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
                              title: 'Continue',
                              backgroundColor: AppTheme.primaryColor,
                              onPressed: () {
                                if(_formKey.currentState!.validate()){
                                   additionalAccountRepo(user_type: "agency",
                                       agency_name: _agencyController.text.trim(),
                                       context: context)
                                .then((value) {
                              if (value.status == true) {
                                controller.getData();

                              }
                              showToast(value.message.toString());
                              Get.toNamed(MyRouter.bottomNavbar);
                            });
                                }
                              },
                              textColor: AppTheme.whiteColor,
                              expandedValue: false,
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );}
}
