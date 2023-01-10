import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../routers/my_router.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class SearchContracts extends StatefulWidget {
  const SearchContracts({Key? key}) : super(key: key);

  @override
  State<SearchContracts> createState() => _SearchContractsState();
}

class _SearchContractsState extends State<SearchContracts> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Contracts",
        )
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: deviceHeight * .02,
            ),
            Row(
              children: const [
                Text(
                  "Active Contracts",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: deviceHeight * .01,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(
                        0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                        color: AppTheme.textColor, fontSize: 14),
                    filled: true,
                    fillColor: Colors.white24,
                    hintText: 'Search contracts',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 13),
                    suffixIcon: Container(
                      padding: const EdgeInsets.all(15),
                      decoration:
                      const BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor,),
                      child: SvgPicture.asset(
                        'assets/icon/Search.svg',
                        color: AppTheme.whiteColor,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: deviceHeight * .01,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
                  width: deviceWidth,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        offset:
                        const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Adobe certificate ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: AppTheme.whiteColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: const Icon(
                                                Icons.clear,
                                                color: Colors.black,
                                              ),
                                            )),
                                        InkWell(
                                          onTap: () => Get.toNamed(
                                              MyRouter.contractsDetailsScreen),
                                          child: const Text(
                                            'View work diary',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.darkBlueText),
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .03,
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              Get.toNamed(MyRouter.chatScreen),
                                          child: const Text(
                                            'Send Message',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.darkBlueText),
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .03,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.more_horiz_outlined,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Hired by: Vijay kumar",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      /* Text(
                        "Soft Co",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textColor3,
                        ),
                      ),
                      Text(
                        "Active: 2:30 hrs this week",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w600),
                      ),*/
                      RichText(
                        text: const TextSpan(
                          text:
                          "Status: ",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textColor,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            /*TextSpan(
                              text: '2:30',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),*/
                            TextSpan(
                              text: "active",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.textColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                //      if (controller.model.value.data!.all![index].type.toString().toLowerCase() == "fixed")
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "\$500",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff130E1D),
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "\$600",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff130E1D),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Budget",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textColor3,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "in Escrow",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textColor3,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                     /* if (controller.model.value.data!.all![index].type
                          .toString()
                          .toLowerCase() ==
                          "fixed")*/
                        const SizedBox(
                          height: 10,
                        ),
                      Row(
                        children: [
                          const Text(
                            "2 Jan 1998 - ",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textColor3,
                            ),
                          ),
                          const Text("present",
                            style:  TextStyle(
                              fontSize: 12,
                              color: AppTheme.textColor3,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * .025,
                      ),
                      CustomOutlineButton(
                        title: "Submit Work",
                        backgroundColor: AppTheme.primaryColor,
                        textColor: AppTheme.whiteColor,
                        expandedValue: true,
                        onPressed: () {
                          Get.toNamed(MyRouter.contractsDetailsScreen,);
                        },
                      )
                    ],
                  ),
                );
              },
            ),

          ],
        ),
      ),

    );
  }
}
