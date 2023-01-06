import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';

import '../../models/proposals/model_offer_proposal.dart';
import '../../repository/proposals/offer_repository.dart';
import '../../resources/app_theme.dart';
import '../../utils/api_contant.dart';
import '../../widgets/custom_appbar.dart';

class ViewOriginalOffer extends StatefulWidget {
  const ViewOriginalOffer({Key? key}) : super(key: key);

  @override
  State<ViewOriginalOffer> createState() => _ViewOriginalOfferState();
}

class _ViewOriginalOfferState extends State<ViewOriginalOffer> {
  String? id;

  Rx<ModelOffer> model = ModelOffer().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;

  @override
  void initState() {
    super.initState();
    id = Get.arguments[0];
    getData();
  }

  void getData() {
    offerRepo(id).then((value) {
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Offer",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "This offer is not available anymore",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4D4D4D)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  const Text(
                    "You have accepted this offer on Oct 15, 2021",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff45414D)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Mobile App And Website design",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4D4D4D)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer...",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff403557)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Divider(
                    color: AppTheme.primaryColor.withOpacity(.49),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/images/user.svg",
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Jolly Smith",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkBlueText),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "United States - Wed 8:10",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff4D4D4D)),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.primaryColor),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.message,
                          color: AppTheme.primaryColor,
                          size: 17,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  CustomOutlineButton(
                    title: "  View Contract  ",
                    backgroundColor: AppTheme.whiteColor,
                    textColor: AppTheme.primaryColor,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
