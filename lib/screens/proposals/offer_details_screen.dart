import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/resources/size.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../../models/model_single_proposal.dart';
import '../../repository/single_proposals_repository.dart';
import '../../widgets/circular_widget.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/error_widget.dart';

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  String? id;
  Rx<SingleProposal> model = SingleProposal().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;

  @override
  void initState() {
    super.initState();
    id = Get.arguments[0];
getData();
  }
  void getData() {
    singleProposalDetailsRepo(id).then((value) {
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
      } else {
        showToast(value.message.toString());
        status.value = RxStatus.error();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Offer details",
          )),
      body: Obx(() {
        return status.value.isSuccess ? SingleChildScrollView(
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
                      title: 'Accept',
                      backgroundColor: AppTheme.primaryColor,
                      onPressed: () {},
                      textColor: AppTheme.whiteColor,
                      expandedValue: false,
                    ),
                  ),
                ),
              ],
            )
          ],
        )) : status.value.isError ? CommonErrorWidget(errorText: model.value.message.toString(), onTap: () { getData(); },) : CircularLoadingWidget(height: 40,) ;
      }),
    );
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
                  child: model.value.data!.clientData!.profileImage.toString() == "" ||
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
                            errorWidget: (_, __, ___) => SvgPicture.asset(
                              "assets/images/user.svg",
                              height: AddSize.size80,
                              width: AddSize.size80,
                            ),
                            placeholder: (_, __) => SvgPicture.asset(
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
                Positioned(
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
                  model.value.data!.clientData!.firstName.toString()+ " " +  model.value.data!.clientData!.lastName.toString(),
                  style: TextStyle(
                      color: Color(0xff4D4D4D),
                      fontSize: AddSize.font18,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppTheme.primaryColor,
                    ),
                    Row(
                      children: [
                        Text(
                          model.value.data!.clientData!.city.toString().isEmpty ? "" : model.value.data!.clientData!.city.toString(),
                          style: TextStyle(
                              color: Color(0xff4D4D4D),
                              fontSize: AddSize.font16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          model.value.data!.clientData!.country.toString(),
                          style: TextStyle(
                              color: Color(0xff4D4D4D),
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
                      color: Color(0xff4D4D4D),
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
                color: Color(0xff4D4D4D),
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
                      color: Color(0xff4D4D4D),
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
                    color: Color(0xff4D4D4D),
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
            child: model.value.data!.projectData!.budgetType.toString().toLowerCase() == "fixed" ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pay by the hour:",
                      style: TextStyle(
                          color: Color(0xff4D4D4D),
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "\$${model.value.data!.proposalData!.amount.toString()}/per hour",
                      style: TextStyle(
                          color: Color(0xff4D4D4D),
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
                      color: Color(0xff4D4D4D),
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Setting a weekly limit is a great way to help ensure you stay on budget",
                  style: TextStyle(
                      color: Color(0xff4D4D4D),
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "${model.value.data!.proposalData!.weeklyLimit.toString()} hrs /week",
                  style: TextStyle(
                      color: Color(0xff4D4D4D),
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "\$200.00 max/week",
                  style: TextStyle(
                      color: Color(0xff4D4D4D),
                      fontSize: AddSize.font14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ) : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Project Budget",
                  style: TextStyle(
                      color: Color(0xff4D4D4D),
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "\$${model.value.data!.proposalData!.amount.toString()}",
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
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                model.value.data!.proposalData!.date.toString(),
                style: TextStyle(
                    color: Color(0xff4D4D4D),
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
