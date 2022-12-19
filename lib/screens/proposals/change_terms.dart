import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/resources/size.dart';

import '../../Controller/jobs_detail_controller.dart';
import '../../controller/proposals_screen_controller.dart';
import '../../models/model_milestones.dart';
import '../../models/proposals/model_submitted_proposal.dart';
import '../../popups/radio_buttons_job_details.dart';
import '../../repository/proposals/change_terms_repository.dart';
import '../../repository/proposals/submitted_proposal_repository.dart';
import '../../routers/my_router.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/progress_indicator.dart';

class ChangeTermsScreen extends StatefulWidget {
  const ChangeTermsScreen({Key? key}) : super(key: key);

  @override
  State<ChangeTermsScreen> createState() => _ChangeTermsScreenState();
}

class _ChangeTermsScreenState extends State<ChangeTermsScreen> {
  String? radioProjectType = "By project";
  final dateFormatForShow = DateFormat('dd-MMM-yyyy');
  final dateFormatForSend = DateFormat('yyyy-MM-dd');
  final controller = Get.put(JobsDetailController());
  List<ModelMilestones> milestone = <ModelMilestones>[
    // ModelMilestones(description: "", amount: "", dueDate: "")
  ];
  dynamic dateInput = 0;
  double price = 0;
  String? id;
  String? type;
  Rx<ModelSubmittedProposal> model = ModelSubmittedProposal().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;



  @override
  void initState() {
    super.initState();
    id = Get.arguments[0];
    type = Get.arguments[1];
    getData();
  }

  void getData() {
    submittedRepo(id, type).then((value) {
      model.value = value;
      if (value.status == true) {
        radioProjectType = model.value.data!.milestonedata!.isEmpty
            ? "By project"
            : "By milestone";
        if (model.value.data!.milestonedata!.isNotEmpty) {
          for (int i = 0; i < model.value.data!.milestonedata!.length; i++) {
            milestonePrice = milestonePrice + double.parse(model.value.data!.milestonedata![i].amount.toString());
            print("milestone total price" + milestonePrice.toString());
            milestone.add(ModelMilestones(
                description: model.value.data!.milestonedata![i].description.toString(),
                amount: model.value.data!.milestonedata![i].amount.toString(),
                dueDate: model.value.data!.milestonedata![i].dueDate.toString(),
            ));
          }
        }
        if (model.value.data!.milestonedata!.isEmpty) {
          price = double.parse(
              model.value.data!.proposalData!.bidAmount.toString());
          _priceController.text = price.toString();
          _feeController.text = ((price! * 20) / 100).toString();
          _receiveController.text = (price! - double.parse(_feeController.text)).toString();
        }
        if (model.value.data!.proposalData!.budgetType.toString() == "fixed") {
          print("duration projext.......");
          controller.durationController.text = model.value.data!.proposalData!.projectDuration.toString();
        }
        status.value = RxStatus.success();
      } else {
        showToast(value.message.toString());
        status.value = RxStatus.error();
      }
    });
  }

  double milestonePrice = 0;
  final proposalController = Get.put(ProposalScreenController());

  final _priceController = TextEditingController();
  final _feeController = TextEditingController();
  final _receiveController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar(
              isLikeButton: false,
              isProfileImage: false,
              titleText: "Change Terms",
            )),
        body: Obx(() {
          return status.value.isSuccess
              ? SingleChildScrollView(
                  child: Column(
                  children: [
                    contentSection(),
                    coverLetter(),
                    //   Message(),
                    AboutTheClient(),
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

  contentSection() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              print(model.value.data!.projectData!.id.toString());
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
          Divider(
            color: AppTheme.primaryColor.withOpacity(.49),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Text(
            "Your Proposed terms",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Form(
            key: _formKey,
            child: SizedBox(
              child: model.value.data!.proposalData!.budgetType
                          .toString()
                          .toLowerCase() ==
                      "fixed"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Client's budget: \$${model.value.data!.projectData!.price.toString()}",
                          style: TextStyle(
                              color: Color(0xff4D4D4D),
                              fontSize: AddSize.font16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: AddSize.size20,
                        ),
                        Text(
                          "How do you want to be paid?",
                          style: TextStyle(
                              color: Color(0xff4D4D4D),
                              fontSize: AddSize.font16,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        RadioListTile(
                            title: Text(
                              "By project",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              "Get your entire payment at the end, when all work has been delivered",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w400),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            value: "By project",
                            groupValue: radioProjectType,
                            onChanged: (value) {
                              setState(() {
                                radioProjectType = value.toString();
                                print(radioProjectType);
                              });
                            }),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        RadioListTile(
                            title: Text(
                              "By milestone",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              "Divide the project into smaller segments, called milestones. You'll be paid for milestones as they are completed and approved",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w400),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            value: "By milestone",
                            groupValue: radioProjectType,
                            onChanged: (value) {
                              setState(() {
                                radioProjectType = value.toString();
                                print(radioProjectType);
                                // milestone.add(ModelMilestones(description: "", amount: "", dueDate: ""));
                              });
                            }),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        SizedBox(
                            child: radioProjectType == "By milestone"
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "How many milestones do you want to include?",
                                        style: TextStyle(
                                            color: Color(0xff4D4D4D),
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: milestone.length,
                                          itemBuilder: (context, index) {
                                            print(milestone.length);
                                            print(milestone);
                                            return mileStones(deviceHeight,
                                                index, milestone[index]);
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            milestone.add(ModelMilestones(
                                                description: "",
                                                amount: "",
                                                dueDate: ""));
                                          });
                                        },
                                        child: Text("+ Add milestone",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.primaryColor)),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .015,
                                      ),
                                      const Divider(
                                        thickness: 0.2,
                                        color: Color(0xff6D2EF1),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      Text(
                                        "Total price of project",
                                        style: TextStyle(
                                            color: AppTheme.darkBlueText,
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      Text(
                                        "This includes all milestones, and is the amount your client will see",
                                        style: TextStyle(
                                            color: Color(0xff4D4D4D),
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      if (model.value.data!.milestonedata!
                                          .isNotEmpty)
                                        Text(
                                          "\$${milestonePrice}",
                                          style: TextStyle(
                                              color: AppTheme.darkBlueText,
                                              fontSize: AddSize.font16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      if (model
                                          .value.data!.milestonedata!.isEmpty)
                                        Text(
                                          "\$${model.value.data!.proposalData!.bidAmount.toString()}",
                                          style: TextStyle(
                                              color: AppTheme.darkBlueText,
                                              fontSize: AddSize.font16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      SizedBox(
                                        height: deviceHeight * .015,
                                      ),
                                      const Divider(
                                        thickness: 0.2,
                                        color: Color(0xff6D2EF1),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      Text(
                                        "Unify Service Fee",
                                        style: TextStyle(
                                            color: AppTheme.darkBlueText,
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      if (int.parse(model.value.data!
                                              .proposalData!.bidAmount
                                              .toString()) !=
                                          0)
                                        Text(
                                          "\$${(double.parse(model.value.data!.proposalData!.bidAmount.toString()) - double.parse(model.value.data!.proposalData!.bidAmount.toString()) * double.parse(model.value.data!.projectData!.serviceFee.toString()) / 100).toString()}",
                                          style: TextStyle(
                                              color: AppTheme.darkBlueText,
                                              fontSize: AddSize.font16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      if (int.parse(model.value.data!
                                              .proposalData!.bidAmount
                                              .toString()) ==
                                          0)
                                        Text(
                                          "\$${(milestonePrice * double.parse(model.value.data!.projectData!.serviceFee.toString()) / 100).toString()}",
                                          style: TextStyle(
                                              color: AppTheme.darkBlueText,
                                              fontSize: AddSize.font16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      SizedBox(
                                        height: deviceHeight * .015,
                                      ),
                                      const Divider(
                                        thickness: 0.2,
                                        color: Color(0xff6D2EF1),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      Text(
                                        "You'll Receive",
                                        style: TextStyle(
                                            color: AppTheme.darkBlueText,
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      Text(
                                        "Your estimated payment. after service fees",
                                        style: TextStyle(
                                            color: Color(0xff4D4D4D),
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      if (int.parse(model.value.data!
                                              .proposalData!.bidAmount
                                              .toString()) !=
                                          0)
                                        Text(
                                          "\$${(int.parse(model.value.data!.proposalData!.bidAmount.toString()) - int.parse(model.value.data!.proposalData!.bidAmount.toString()) * int.parse(model.value.data!.projectData!.serviceFee.toString()) / 100).toString()}",
                                          style: TextStyle(
                                              color: AppTheme.darkBlueText,
                                              fontSize: AddSize.font16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      if (int.parse(model.value.data!
                                              .proposalData!.bidAmount
                                              .toString()) ==
                                          0)
                                        Text(
                                          "\$${(milestonePrice - milestonePrice * int.parse(model.value.data!.projectData!.serviceFee.toString()) / 100).toString()}",
                                          style: TextStyle(
                                              color: AppTheme.darkBlueText,
                                              fontSize: AddSize.font16,
                                              fontWeight: FontWeight.w600),
                                        ),

                                      /*Text(
              "\$0.00",
              style: TextStyle(
                  color: AppTheme.darkBlueText,
                  fontSize: AddSize.font16,
                  fontWeight: FontWeight.w600),
            ),*/
                                      SizedBox(
                                        height: deviceHeight * .02,
                                      ),
                                      Text(
                                        "How long will this project take?",
                                        style: TextStyle(
                                            color: AppTheme.darkBlueText,
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      TextFormField(
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return RadioButtonsJobDetails();
                                            },
                                          );
                                        },
                                        readOnly: true,
                                        controller:
                                            controller.durationController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          hintText: "Select a duration",
                                          focusColor: AppTheme.primaryColor,
                                          suffixIcon: Icon(Icons
                                              .keyboard_arrow_down_outlined),
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.hintTextColor),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Select a duration'),
                                        ]),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "What is the rate you'd like to bid for this job?",
                                        style: TextStyle(
                                            color: AppTheme.darkBlueText,
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: AddSize.size10,
                                      ),
                                      Text(
                                        "Bid",
                                        style: TextStyle(
                                            color: AppTheme.darkBlueText,
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Total amount the client will see on your proposal",
                                        style: TextStyle(
                                            color: Color(0xff4D4D4D),
                                            fontSize: AddSize.font14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CustomTextField(
                                        inputFormatters1: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: _priceController,
                                        onChanged: (value) {
                                          price = double.parse(value);
                                          _feeController.text =
                                              ((price! * 20) / 100).toString();
                                          _receiveController.text = (price! -
                                                  double.parse(
                                                      _feeController.text))
                                              .toString();
                                        },
                                        onFieldSubmitted: (value) {
                                          price = double.parse(value);
                                          _feeController.text =
                                              ((price! * 20) / 100).toString();
                                          _receiveController.text = (price! -
                                                  double.parse(
                                                      _feeController.text))
                                              .toString();
                                        },
                                        obSecure: false.obs,
                                        hintText: "".obs,
                                        prefix: Icon(Icons.attach_money),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  'Bid price is required'),
                                        ]),
                                      ),
                                      SizedBox(
                                        height: AddSize.size10,
                                      ),
                                      Text(
                                        "Unify Service Fee",
                                        style: TextStyle(
                                            color: AppTheme.darkBlueText,
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CustomTextField(
                                        enabled: false,
                                        controller: _feeController,
                                        readOnly: true,
                                        obSecure: false.obs,
                                        hintText: "".obs,
                                        prefix: Icon(Icons.attach_money),
                                      ),
                                      SizedBox(
                                        height: AddSize.size10,
                                      ),
                                      Text(
                                        "You'll Receive",
                                        style: TextStyle(
                                            color: AppTheme.darkBlueText,
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Total amount the client will see on your proposal",
                                        style: TextStyle(
                                            color: Color(0xff4D4D4D),
                                            fontSize: AddSize.font14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CustomTextField(
                                        enabled: false,
                                        controller: _receiveController,
                                        readOnly: true,
                                        obSecure: false.obs,
                                        hintText: "".obs,
                                        prefix: Icon(Icons.attach_money),
                                      ),
                                      Text(
                                        "How long will this project take?",
                                        style: TextStyle(
                                            color: AppTheme.darkBlueText,
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      TextFormField(
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return RadioButtonsJobDetails();
                                            },
                                          );
                                        },
                                        readOnly: true,
                                        controller:
                                            controller.durationController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          hintText: "Select a duration",
                                          focusColor: AppTheme.primaryColor,
                                          suffixIcon: Icon(Icons
                                              .keyboard_arrow_down_outlined),
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.hintTextColor),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Select a duration'),
                                        ]),
                                      ),
                                    ],
                                  )),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your applied price \$${model.value.data!.proposalData!.bidAmount.toString()}",
                          style: TextStyle(
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Text(
                          "Hourly Rate",
                          style: TextStyle(
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Total amount the client will see on your proposal",
                          style: TextStyle(
                              color: Color(0xff4D4D4D),
                              fontSize: AddSize.font14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          inputFormatters1: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _priceController,
                          onChanged: (value) {
                            price = double.parse(value);
                            _feeController.text =
                                ((price! * 20) / 100).toString();
                            _receiveController.text =
                                (price! - double.parse(_feeController.text))
                                    .toString();
                          },
                          onFieldSubmitted: (value) {
                            price = double.parse(value);
                            _feeController.text =
                                ((price! * 20) / 100).toString();
                            _receiveController.text =
                                (price! - double.parse(_feeController.text))
                                    .toString();
                          },
                          obSecure: false.obs,
                          hintText: "".obs,
                          prefix: Icon(Icons.attach_money),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'hourly price is required'),
                          ]),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Text(
                          "${model.value.data!.projectData!.serviceFee.toString()}% Unify Service Fee",
                          style: TextStyle(
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font16,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          enabled: false,
                          controller: _feeController,
                          readOnly: true,
                          obSecure: false.obs,
                          hintText: "".obs,
                          prefix: Icon(Icons.attach_money),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Text(
                          "You'll Receive",
                          style: TextStyle(
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Total amount the client will see on your proposal",
                          style: TextStyle(
                              color: Color(0xff4D4D4D),
                              fontSize: AddSize.font14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          enabled: false,
                          controller: _receiveController,
                          readOnly: true,
                          obSecure: false.obs,
                          hintText: "".obs,
                          prefix: Icon(Icons.attach_money),
                        ),
                      ],
                    ),
            ),
          ),
          SizedBox(
            height: AddSize.size30,
          ),
          CustomOutlineButton(
              title: "Submit",
              backgroundColor: AppTheme.primaryColor,
              textColor: AppTheme.whiteColor,
              expandedValue: true,
              onPressed: () {
                if( radioProjectType == "By milestone"){
                  for(int i = 0; i < milestone.length; i++){
                    milestone[i].dueDate = dateFormatForSend.format(DateTime.parse(milestone[i].dueDate.toString())).toString();
                    print(milestone[i].dueDate);
                  }
                }
                if (_formKey.currentState!.validate()) {
                  updateProposalRepo(
                          model.value.data!.proposalData!.id.toString(), _priceController.text.trim(),
                      model.value.data!.projectData!.budgetType.toString().toLowerCase() == "hourly" ? ""
                              : radioProjectType == "By project" ? "single" : "multiple",
                          jsonEncode(milestone),
                          controller.durationController.text,
                          context)
                      .then((value) {
                        if(value.status == true){
                        //  Get.offAllNamed(MyRouter.bottomNavbar);
                          Get.back();
                          Get.back();

                        }
                        showToast(value.message.toString());
                  });
                }
              }),
          SizedBox(
            height: AddSize.size20,
          ),
          CustomOutlineButton(
            title: "Cancel",
            backgroundColor: AppTheme.whiteColor,
            textColor: AppTheme.primaryColor,
            expandedValue: true,
            onPressed: () {
              Get.back();
            },
          )
        ]));
  }

  Column mileStones(double deviceHeight, int index, listIndex) {
    final TextEditingController _descriptionController = TextEditingController();
    final TextEditingController _dueDateController = TextEditingController();
    final TextEditingController _amountController = TextEditingController();

    /*   Map map = <String,dynamic>{};
    map["description"] = _descriptionController.text;
    map["Due date"] = _dueDateController.text;
    map["amount"] = _amountController.text;*/
    // milestone.contains(index,ModelMilestones(description: _descriptionController.text.trim() ,amount: _amountController.text.trim(),dueDate:_dueDateController.text.trim()));
    _descriptionController.text = milestone[index].description.toString();
    _dueDateController.text = milestone[index].dueDate.toString() != "" ? dateFormatForShow.format(DateTime.parse(milestone[index].dueDate.toString())) : "";
    _amountController.text = milestone[index].amount.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: deviceHeight * .01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${index + 1} Description",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff180D31)),
            ),
            index == 0
                ? SizedBox()
                : IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        milestone.removeLast();
                      });
                    },
                  )
          ],
        ),
        CustomTextField(
          controller: _descriptionController,
          obSecure: false.obs,
          keyboardType: TextInputType.text,
          hintText: "".obs,
          onChanged: (value) {
            milestone[index].description = value.toString();
          },
          validator: MultiValidator([
            RequiredValidator(errorText: 'Description is required'),
          ]),
        ),
        SizedBox(
          height: deviceHeight * .02,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Due date",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff180D31)),
                  ),
                  CustomTextField(
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        print(pickedDate);
                        //  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        _dueDateController.text = dateFormatForShow.format(pickedDate);
                        print(pickedDate.millisecondsSinceEpoch);
                        setState(() {
                          dateInput = _dueDateController.text;
                          milestone[index].dueDate = pickedDate.toString();
                        });
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: AppTheme.primaryColor,
                    ),
                    controller: _dueDateController,
                    obSecure: false.obs,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "".obs,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Due date is required'),
                    ]),
                    /*onChanged: (value) {
                      milestone[index].dueDate = value.toString();
                    },*/
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Amount",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff180D31)),
                  ),
                  CustomTextField(
                    controller: _amountController,
                    prefix: Icon(
                      Icons.attach_money,
                      size: 20,
                      color: AppTheme.primaryColor,
                    ),
                    onChanged: (value) {
                      milestone[index].amount = value.toString();
                    },
                    obSecure: false.obs,
                    inputFormatters1: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.emailAddress,
                    hintText: "".obs,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Amount is required'),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * .015,
        ),
        const Divider(
          thickness: 0.2,
          color: Color(0xff6D2EF1),
        ),
        SizedBox(
          height: deviceHeight * .01,
        ),
      ],
    );
  }

  coverLetter() {
    return Container(
      margin: const EdgeInsets.symmetric(/*vertical: 15,*/ horizontal: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
          )
        ],
      ),
      child: Theme(
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
                "Cover letter",
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
                  model.value.data!.proposalData!.coverLetter.toString(),
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ]),
        ),
      ),
    );
  }

  /* Message() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
          )
        ],
      ),
      child: Theme(
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
                "Message",
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
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's.",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ]),
        ),
      ),
    );
  }*/

  AboutTheClient() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
          )
        ],
      ),
      child: Theme(
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
                "About the client",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font20,
                    fontWeight: FontWeight.w600),
              ),
              children: [
                SizedBox(
                  height: AddSize.size10,
                ),
                Row(
                  children: [
                    Icon(Icons.verified,
                        color: model.value.data!.clientData!.paymentVerified ==
                                true
                            ? AppTheme.primaryColor
                            : Colors.grey.withOpacity(.49),
                        size: 20),
                    SizedBox(
                      width: AddSize.size10,
                    ),
                    Text(
                      model.value.data!.clientData!.paymentVerified == true
                          ? "Payment method verified"
                          : "Payment method not verified",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4D4D4D),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
                Row(
                  children: [
                    Wrap(
                      children: List.generate(
                          5,
                          (index) => double.parse(model
                                      .value.data!.clientData!.rating
                                      .toString()) >
                                  index
                              ? Icon(
                                  Icons.star,
                                  color: AppTheme.pinkText,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.star_border_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                )),
                    ),
                    SizedBox(
                      width: AddSize.size10,
                    ),
                    Text(
                      "${double.parse(model.value.data!.clientData!.rating.toString())} of ${double.parse(model.value.data!.clientData!.numberOfReview.toString())} reviews",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff170048)),
                    ),
                  ],
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.value.data!.clientData!.country.toString(),
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        Text(
                          model.value.data!.clientData!.city.toString() +
                              model.value.data!.clientData!.localTime
                                  .toString(),
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Text(
                          "${model.value.data!.clientData!.jobPosted.toString()} jobs posted",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        Text(
                          "${model.value.data!.projectData!.hireRate.toString()}% hire rate, ${model.value.data!.projectData!.openJobs.toString()} open job",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Text(
                          "\$${model.value.data!.clientData!.moneySpent.toString()}+ total spent",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        Text(
                          "${model.value.data!.projectData!.totalHire.toString()} hires, ${model.value.data!.projectData!.openJobs.toString()} active",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Text(
                          model.value.data!.projectData!.projectDuration
                              .toString(),
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        Text(
                          "Project Length",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size15,
                        ),
                        Text(
                          companySize(double.parse(model
                                          .value.data!.clientData!.employeeNo
                                          .toString() ==
                                      "null" ||
                                  model.value.data!.clientData!.employeeNo
                                          .toString() ==
                                      ""
                              ? "0"
                              : model.value.data!.clientData!.employeeNo
                                  .toString())),
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size15,
                        ),
                        Text(
                          "Member since ${model.value.data!.clientData!.memberSince.toString()}",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }

  String companySize(double numberOfEmp) {
    if (numberOfEmp <= 10) {
      return "Company size (1 to 10 people)";
    } else if (numberOfEmp <= 100) {
      return "Company size (10 to 100 people)";
    } else if (numberOfEmp <= 1000) {
      return "Company size (10 to 100 people)";
    } else {
      return "Company size (1000+ people)";
    }
  }
}
