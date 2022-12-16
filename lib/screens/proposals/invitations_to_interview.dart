import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/controller/proposals_screen_controller.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../../models/proposals/model_decline_reason_list.dart';
import '../../models/proposals/model_invite.dart';
import '../../repository/proposals/decline_invite_repository.dart';
import '../../repository/proposals/decline_reason_list.dart';
import '../../repository/proposals/invite_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/progress_indicator.dart';

class InvitationsToInterview extends StatefulWidget {
  const InvitationsToInterview({Key? key}) : super(key: key);

  @override
  State<InvitationsToInterview> createState() => _InvitationsToInterviewState();
}

class _InvitationsToInterviewState extends State<InvitationsToInterview> {
  String? id;
  Rx<ModelInvite> model = ModelInvite().obs;
  Rx<RxStatus> status = RxStatus
      .empty()
      .obs;
  Rx<RxStatus> reasonListStatus = RxStatus
      .empty()
      .obs;
  Rx<ModelDeclineReasonList> modelReasonList = ModelDeclineReasonList().obs;

  void getReasonList() {
    declineReasonListRepo("invite").then((value) {
      modelReasonList.value = value;
      if (value.status == true) {
        reasonListStatus.value = RxStatus.success();
      } else {
        reasonListStatus.value = RxStatus.error();
      }
    });
  }

  RxString reasonValue = "".obs;

  @override
  void initState() {
    super.initState();
    id = Get.arguments[0];
    getData();
    getReasonList();
  }

  void getData() {
    inviteRepo(id).then((value) {
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
      } else {
        showToast(value.message.toString());
        status.value = RxStatus.error();
      }
    });
  }


  final controller = Get.put(ProposalScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar(
              isLikeButton: false,
              isProfileImage: false,
              titleText: "Invitation details",
            )),
        body: Obx(() {
          return status.value.isSuccess
              ? SingleChildScrollView(
              child: Column(
                children: [
                  contentSection(),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomOutlineButton(
                            title: 'Decline',
                            backgroundColor: AppTheme.whiteColor,
                            onPressed: () {
                              declineOffer(context);
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
                            title: 'Accept',
                            backgroundColor: AppTheme.primaryColor,
                            onPressed: () {
                              Get.toNamed(
                                  MyRouter.submitProposalScreen, arguments: [
                                int.parse(model.value.data!.projectData!.id.toString()),
                                model.value.data!.projectData!.name.toString(),
                                model.value.data!.projectData!.description.toString(),
                                model.value.data!.projectData!.price.toString(),
                                model.value.data!.projectData!.budgetType.toString(),
                               "fromInvite",
                                model.value.data!.proposalData!.id.toString(),
                               // model.value.data!.clientData!.id.toString(),
                              ]);
                            },
                            textColor: AppTheme.whiteColor,
                            expandedValue: false,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))
              : status.value.isError
              ? CommonErrorWidget(
            errorText: model.value.message.toString(),
            onTap: () {
              getData();
            },
          )
              : CommonProgressIndicator();
        }));
  }

//contract information
  contentSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.value.data!.projectData!.name.toString(),
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font24,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              CustomOutlineButton(
                title: model.value.data!.projectData!.categories.toString(),
                backgroundColor: AppTheme.whiteColor,
                textColor: AppTheme.primaryColor,
                onPressed: () {},
              ),
              SizedBox(
                width: AddSize.size10,
              ),
              Text(
                model.value.data!.projectData!.postedDate.toString(),
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: AddSize.size20,
          ),
          Text(
            model.value.data!.projectData!.description.toString(),
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font14,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: AddSize.size20,
          ),
          InkWell(
            onTap: () {
              Get.toNamed(MyRouter.jobDetailsScreen,
                  arguments: [model.value.data!.projectData!.id.toString()]);
            },
            child: Text(
              "View job posting",
              style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: AddSize.font16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Text(
            "About the client",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size10,
          ),

          Row(
            children: [
              Icon(Icons.verified,
                  color: model.value.data!.clientData!.paymentVerified == true
                      ? AppTheme.primaryColor
                      : Colors.grey.withOpacity(.49), size: 20),
              SizedBox(
                width: 3,
              ),
              Text(
                model.value.data!.clientData!.paymentVerified == true
                    ? "Payment method verified"
                    : "Payment method not verified",
                style: TextStyle(
                    color: model.value.data!.clientData!.paymentVerified == true
                        ? AppTheme.primaryColor
                        : Colors.grey.withOpacity(.49),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),

          SizedBox(
            height: AddSize.size15,
          ),
          Text(
            "Location",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size5,
          ),
          Text(
            model.value.data!.clientData!.country.toString(),
            style: TextStyle(
                color: Color(0xff403557),
                fontSize: AddSize.font18,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size5,
          ),
          Text(
            model.value.data!.clientData!.localTime.toString(),
            style: TextStyle(
                color: Color(0xff403557),
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Divider(
            color: AppTheme.primaryColor.withOpacity(.39),
          ),
          Theme(
            data: ThemeData(
                expansionTileTheme: ExpansionTileThemeData(
                    textColor: AppTheme.primaryColor,
                    iconColor: AppTheme.primaryColor))
                .copyWith(dividerColor: Colors.transparent),
            child: ListTileTheme(
              contentPadding: EdgeInsets.zero,
              child: ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  title: Text(
                    "Activity on this job",
                    style: TextStyle(
                        color: Color(0xff4D4D4D),
                        fontSize: AddSize.font20,
                        fontWeight: FontWeight.w600),
                  ),
                  children: [
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Text(
                      "Proposals: ${model.value.data!.projectData!.proposalCount
                          .toString()}",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Divider(
            color: AppTheme.primaryColor.withOpacity(.39),
          ),
          Theme(
            data: ThemeData(
                expansionTileTheme: ExpansionTileThemeData(
                    textColor: AppTheme.primaryColor,
                    iconColor: AppTheme.primaryColor))
                .copyWith(dividerColor: Colors.transparent),
            child: ListTileTheme(
              contentPadding: EdgeInsets.zero,
              child: ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  title: Text(
                    "Original message from client",
                    style: TextStyle(
                        color: Color(0xff4D4D4D),
                        fontSize: AddSize.font20,
                        fontWeight: FontWeight.w600),
                  ),
                  children: [
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Text(
                      model.value.data!.proposalData!.description.toString(),
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  declineOffer(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _reasonController = TextEditingController();
    final _messageController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.size100 * .4),
            child: Obx(() {
              return reasonListStatus.value.isSuccess
                  ? Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(

                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Text(
                          "Decline",
                          style: TextStyle(
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font16,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: AddSize.size25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reason",
                              style: TextStyle(
                                  color: Color(0xff4D4D4D),
                                  fontSize: AddSize.font16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: AddSize.size5,
                            ),
                            Obx(() {
                              return DropdownButtonFormField<
                                  dynamic>(
                                isExpanded: true,
                                menuMaxHeight: AddSize.screenHeight * .54,
                                value: reasonValue.value == ""
                                    ? null
                                    : reasonValue.value,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select reason';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Select a reason",
                                  hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff596681)),
                                  counterText: "",
                                  filled: true,
                                  fillColor: AppTheme.whiteColor,
                                  focusColor: AppTheme.whiteColor,
                                  contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8,
                                  ),
                                  focusedBorder:
                                  OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor
                                            .withOpacity(.15), width: 1.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor
                                            .withOpacity(.15), width: 1.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor
                                            .withOpacity(.15), width: 1.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                // Down Arrow Icon
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                items: List.generate(
                                    modelReasonList.value.data!.length,
                                        (index) =>
                                        DropdownMenuItem(
                                          value: modelReasonList.value
                                              .data![index].title.toString(),
                                          child: Text(
                                            modelReasonList.value.data![index]
                                                .title.toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Color(
                                                    0xff596681)),
                                          ),
                                          // onTap: (){
                                          //      setState(() {
                                          //        timezoneValue = controller.timezoneList.data![index].timezone.toString();
                                          //        print(timezoneValue);
                                          //      });
                                          //
                                          // },
                                        )),
                                onChanged: (newValue) {
                                  reasonValue.value = newValue;
                                },
                              );
                            }),

                            SizedBox(
                              height: AddSize.size10,
                            ),
                            Text(
                              "Message (optional)",
                              style: TextStyle(
                                  color: Color(0xff4D4D4D),
                                  fontSize: AddSize.font16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: AddSize.size5,
                            ),
                            CustomTextField(
                              controller: _messageController,
                              isMulti: true,
                              obSecure: false.obs,
                              keyboardType: TextInputType.text,
                              hintText: "".obs,
                            ),
                            SizedBox(
                              height: AddSize.size10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CustomOutlineButton(
                                      title: 'Cancel',
                                      backgroundColor: AppTheme.whiteColor,
                                      onPressed: () {
                                        Get.back();
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
                                      title: 'Decline',
                                      backgroundColor: AppTheme.primaryColor,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          inviteDeclineRepo(invitaion_id: model.value.data!.proposalData!.id.toString(),
                                              reason: reasonValue.value,
                                              description: _messageController.text.trim(),
                                              context: context
                                          ).then((value) {
                                            if (value.status == true) {
                                              Get.offNamed(
                                                  MyRouter.bottomNavbar);
                                              controller.getData();
                                            }
                                            showToast(value.message.toString());
                                          });
                                        }
                                      },
                                      textColor: AppTheme.whiteColor,
                                      expandedValue: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )   : reasonListStatus.value.isError
                  ? CommonErrorWidget(
                  errorText: modelReasonList.value.message.toString(),
                  onTap: () {
                    getReasonList();
                  })
                  : CommonProgressIndicator();
            }),
          );
        });
  }

}
