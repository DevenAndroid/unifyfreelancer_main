import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/resources/size.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';
import 'package:unifyfreelancer/widgets/progress_indicator.dart';

import '../../models/proposals/model_decline_reason_list.dart';
import '../../models/proposals/model_offer_proposal.dart';
import '../../repository/proposals/accept_offer_repository.dart';
import '../../repository/proposals/decline_offer_repository.dart';
import '../../repository/proposals/decline_reason_list.dart';
import '../../repository/proposals/offer_repository.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/error_widget.dart';

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  String? id;
  Rx<ModelOffer> model = ModelOffer().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;
  Rx<RxStatus> reasonListStatus = RxStatus.empty().obs;
  Rx<ModelDeclineReasonList> modelReasonList = ModelDeclineReasonList().obs;

  @override
  void initState() {
    super.initState();
    id = Get.arguments[0];
    getData();
    getReasonList();
  }

  void getData() {
    offerRepo(id).then((value) {
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
          if (model.value.data!.milestonedata!.isNotEmpty) {
            for (int i = 0; i < model.value.data!.milestonedata!.length; i++) {
              milestonePrice = milestonePrice + double.parse(model.value.data!.milestonedata![i].amount.toString());
              if (kDebugMode) {
                print("milestone total price$milestonePrice");
              }
        } }
      } else {
        showToast(value.message.toString());
        status.value = RxStatus.error();
      }
    });
  }

  void getReasonList() {
    declineReasonListRepo("offer").then((value) {
      modelReasonList.value = value;
      if (value.status == true) {
        reasonListStatus.value = RxStatus.success();
      } else {
        reasonListStatus.value = RxStatus.error();
      }
    });
  }

  RxString reasonValue = "".obs;

  final dateFormatForShow = DateFormat('dd-MMM-yyyy');

  double milestonePrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Offer details",
          )),
      body: Obx(() {
        return status.value.isSuccess
            ? SingleChildScrollView(
            child: Column(
              children: [
                profileSection(),
                //  companyInfoSection(),
                contractInfoSection(),
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
                            acceptOfferRepo(id).then((value) {
                              if (value.status == true) {
                                Get.back();
                              }
                              showToast(value.message.toString());
                            });
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
            : const CommonProgressIndicator();
      }),
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
              return reasonListStatus.value.isSuccess ? Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Text(
                          "Decline offer",
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
                                  color: const Color(0xff4D4D4D),
                                  fontSize: AddSize.font16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: AddSize.size5,
                            ),
                            Obx(() {
                              return DropdownButtonFormField<dynamic>(
                                isExpanded: true,
                                menuMaxHeight: AddSize.screenHeight * .54,
                                value: reasonValue.value == "" ? null : reasonValue.value,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select reason';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Select a reason",
                                  hintStyle: const TextStyle(
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
                                    borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  border:OutlineInputBorder(
                                    borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                // Down Arrow Icon
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                items: List.generate(
                                    modelReasonList.value.data!.length,
                                        (index) => DropdownMenuItem(
                                      value: modelReasonList.value.data![index].title.toString(),
                                      child: Text(
                                        modelReasonList.value.data![index].title.toString(),
                                        style: const TextStyle(
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
                            /*CustomTextField(
                            controller: _reasonController,
                            obSecure: false.obs,
                            keyboardType: TextInputType.text,
                            hintText: "".obs,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Reason is required'),
                            ]),
                          ),*/
                            SizedBox(
                              height: AddSize.size10,
                            ),
                            Text(
                              "Message (optional)",
                              style: TextStyle(
                                  color: const Color(0xff4D4D4D),
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
                                          declineOfferRepo(
                                              offer_id: id,
                                              reason: reasonValue.value,
                                              description: _messageController
                                                  .text.trim(),
                                              context: context)
                                              .then((value) {
                                            if (value.status == true) {
                                              Get.offAllNamed(
                                                  MyRouter.bottomNavbar);
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
              )
                  : reasonListStatus.value.isError
                  ? CommonErrorWidget(
                  errorText: modelReasonList.value.message.toString(),
                  onTap: () {
                    getReasonList();
                  })
                  : const CommonProgressIndicator();
            }),
          );
        });
  }

//profile section
  profileSection() {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
        child: Row(
          children: [
            Stack(
              children: [
                SizedBox(
                  child: model.value.data!.clientData!.profileImage
                      .toString() ==
                      "" ||
                      model.value.data!.clientData!.profileImage == null ||
                      model.value.data!.clientData!.profileImage == "null"
                      ? SvgPicture.asset(
                    "assets/images/user.svg",
                    height: AddSize.size80,
                    width: AddSize.size80,
                  )
                      : ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: CachedNetworkImage(
                        imageUrl:
                        model.value.data!.clientData!.profileImage ??
                            "",
                        height: AddSize.size80,
                        width: AddSize.size80,
                        errorWidget: (_, __, ___) =>
                            SvgPicture.asset(
                              "assets/images/user.svg",
                              height: AddSize.size80,
                              width: AddSize.size80,
                            ),
                        placeholder: (_, __) =>
                            SvgPicture.asset(
                              "assets/images/user.svg",
                              height: AddSize.size80,
                              width: AddSize.size80,
                            ),
                        fit: BoxFit.cover,
                      ) /*Image.file(
                              profileImage.value,
                              fit: BoxFit.cover,
                            ),*/
                  ),
                ),
                const Positioned(
                    right: 0,
                    top: 10,
                    child: Icon(
                      Icons.circle,
                      size: 15,
                      color: Colors.transparent,
                    ))
              ],
            ),
            SizedBox(
              width: AddSize.size20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.value.data!.clientData!.firstName.toString() +
                      " " +
                      model.value.data!.clientData!.lastName.toString(),
                  style: TextStyle(
                      color: const Color(0xff4D4D4D),
                      fontSize: AddSize.font18,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppTheme.primaryColor,
                    ),
                    Row(
                      children: [
                        Text(
                          model.value.data!
                              .clientData!
                              .city
                              .toString()
                              .isEmpty
                              ? ""
                              : model.value.data!.clientData!.city.toString() +
                              ",",
                          style: TextStyle(
                              color: const Color(0xff4D4D4D),
                              fontSize: AddSize.font16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          model.value.data!.clientData!.country.toString(),
                          style: TextStyle(
                              color: const Color(0xff4D4D4D),
                              fontSize: AddSize.font16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  model.value.data!.clientData!.timezone.toString(),
                  style: TextStyle(
                      color: const Color(0xff4D4D4D),
                      fontSize: AddSize.font14,
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
      );
    });
  }

  //Company information

/*  companyInfoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
      child: Row(
        children: [
          SvgPicture.asset("assets/icon/company.svg"),
          SizedBox(
            width: AddSize.size15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Associated with an agency",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "www.deepaksoni.com",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }*/

//contract information
  contractInfoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(/*vertical: 15,*/ horizontal: 12),
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
            "Contract Terms",
            style: TextStyle(
                color: const Color(0xff4D4D4D),
                fontSize: AddSize.font18,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          RichText(
              text: TextSpan(
                  text: "Unify payment protection.",
                  style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w600),
                  children: [
                    TextSpan(
                      text: " only pay for the work you authorize.",
                      style: TextStyle(
                          color: const Color(0xff4D4D4D),
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500),
                    )
                  ])),
          SizedBox(
            height: AddSize.size20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment option:",
                style: TextStyle(
                    color: const Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                model.value.data!.projectData!.budgetType.toString(),
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: AddSize.size15,
          ),
          SizedBox(
            child: model.value.data!.projectData!.budgetType
                .toString()
                .toLowerCase() ==
                "hourly"
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pay by the hour:",
                      style: TextStyle(
                          color: const Color(0xff4D4D4D),
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "\$${model.value.data!.proposalData!.bidAmount ??
                          "0"}/per hour",
                      style: TextStyle(
                          color: const Color(0xff4D4D4D),
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "Weekly Limit",
                  style: TextStyle(
                      color: const Color(0xff4D4D4D),
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Setting a weekly limit is a great way to help ensure you stay on budget",
                  style: TextStyle(
                      color: const Color(0xff4D4D4D),
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "${model.value.data!.proposalData!.weeklyLimit ??
                      "0"} hrs /week",
                  style: TextStyle(
                      color: const Color(0xff4D4D4D),
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "\$${double.parse(
                      model.value.data!.proposalData!.bidAmount.toString() ?? "0") *
                      double.parse(
                          (model.value.data!.proposalData!.weeklyLimit ?? "0")
                              .toString())} max/week",
                  style: TextStyle(
                      color: const Color(0xff4D4D4D),
                      fontSize: AddSize.font14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
                : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Project Budget",
                  style: TextStyle(
                      color: const Color(0xff4D4D4D),
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w600),
                ),
                if(model.value.data!.milestonedata!.isNotEmpty)
                  Text(
                    "\$${milestonePrice.toString()}",
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: AddSize.font16,
                        fontWeight: FontWeight.w600),
                  ),
                if(model.value.data!.milestonedata!.isEmpty)
                Text(
                  "\$${model.value.data!.proposalData!.bidAmount.toString()}",
                  style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start Date:",
                style: TextStyle(
                    color: const Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                dateFormatForShow.format(DateTime.parse(model.value.data!.proposalData!.createdDate.toString())),
                style: TextStyle(
                    color: const Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
