import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/size.dart';
import 'package:unifyfreelancer/screens/questions_screens/page1.dart';
import 'package:unifyfreelancer/screens/questions_screens/page2.dart';
import 'package:unifyfreelancer/screens/questions_screens/page3.dart';
import '../../resources/app_theme.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppTheme.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: AppTheme.whiteColor,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff756C87),
            )),
        title: Text(
          "Freelancer",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
              fontSize: AddSize.font20),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(AddSize.screenWidth, AddSize.size50),
          child: Container(
            height: AddSize.size10,
            color: AppTheme.primaryColor,
          ),
        ),
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: [
          Page1(),
          Page2(),
          Page3(),
        ],
      ),
    );
  }

  // page1() {
  //   return Container(
  //     padding: EdgeInsets.all(12),
  //     height: AddSize.screenHeight,
  //     width: AddSize.screenWidth,
  //     child: SingleChildScrollView(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(
  //             height: AddSize.size10,
  //           ),
  //           Text(
  //             "Hey ZabuZa. Ready for your next big opportunity's ?",
  //             style: TextStyle(
  //                 fontWeight: FontWeight.w600,
  //                 color: AppTheme.darkBlueText,
  //                 fontSize: AddSize.font20),
  //           ),
  //           SizedBox(
  //             height: AddSize.size50,
  //           ),
  //           Row(
  //             children: [
  //               Padding(
  //                 padding:  EdgeInsets.only(
  //                   right: AddSize.padding20,
  //                 ),
  //                 child: Icon(Icons.person),
  //               ),
  //               Expanded(
  //                 child: Text(
  //                   "Answer a few questions and start building your profile",
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.w500,
  //                       color: AppTheme.textColor,
  //                       fontSize: AddSize.font14),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(
  //             height: AddSize.size20,
  //           ),
  //           Divider(
  //             color: AppTheme.primaryColor.withOpacity(.49),
  //           ),
  //           SizedBox(
  //             height: AddSize.size20,
  //           ),
  //           Row(
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.only(
  //                     right: AddSize.padding20,
  //                 ),
  //                 child: Icon(Icons.mail_lock_outlined),
  //               ),
  //               Expanded(
  //                 child: Text(
  //                   "Apply for open roles or list services for clients to  buy",
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.w500,
  //                       color: AppTheme.textColor,
  //                       fontSize: AddSize.font14),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(
  //             height: AddSize.size20,
  //           ),
  //           Divider(
  //             color: AppTheme.primaryColor.withOpacity(.49),
  //           ),
  //           SizedBox(
  //             height: AddSize.size20,
  //           ),
  //           Row(
  //             children: [
  //               Padding(
  //                 padding:  EdgeInsets.only(
  //                   right: AddSize.padding20,
  //                 ),
  //                 child: Icon(Icons.monetization_on),
  //               ),
  //               Expanded(
  //                 child: Text(
  //                   "Get paid safely and know we're there to help",
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.w500,
  //                       color: AppTheme.textColor,
  //                       fontSize:AddSize.font14 ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(
  //             height: AddSize.size20,
  //           ),
  //           Divider(
  //             color: AppTheme.primaryColor.withOpacity(.49),
  //           ),
  //           SizedBox(
  //             height: AddSize.size125,
  //           ),
  //           Text(
  //             "It only takes 5 -10 minutes and you can edit it later, We'll save as you go",
  //             style: TextStyle(
  //                 fontWeight: FontWeight.w500,
  //                 color: AppTheme.textColor,
  //                 fontSize: AddSize.font12),
  //           ),
  //           SizedBox(
  //             height: AddSize.size20,
  //           ),
  //           CustomOutlineButton(
  //             title: "Get Started",
  //             backgroundColor: AppTheme.primaryColor,
  //             textColor: AppTheme.whiteColor,
  //             expandedValue: true,
  //             onPressed: () {},
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
//   RxInt curreentIndex = 1.obs;
//
//   page2() {
//     return Container(
//       padding: EdgeInsets.all(12),
//       height: AddSize.screenHeight,
//       width: AddSize.screenWidth,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: AddSize.size10,
//             ),
//             Text(
//               "A few quick questions first, have you freelanced before?",
//               style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: AppTheme.darkBlueText,
//                   fontSize: AddSize.font20),
//             ),
//             SizedBox(
//               height: AddSize.size20,
//             ),
//             Text(
//               "This lets us know how much help to give you along the way.",
//               style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: AppTheme.darkBlueText,
//                   fontSize: AddSize.font14),
//             ),
//             SizedBox(
//               height: AddSize.size10*.1,
//             ),
//             Text(
//               "(We won't share your answer with anyone else, including potential clients.)",
//               style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: AppTheme.textColor,
//                   fontSize: AddSize.font14),
//             ),
//             SizedBox(
//               height: AddSize.size20,
//             ),
//             ListView.builder(
//               itemCount: 3,
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) =>
//                 Obx(() {
//   return Padding(
//                   padding: EdgeInsets.only(bottom: AddSize.size20),
//                   child: InkWell(
//                     onTap: (){
//                       curreentIndex.value = index;
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(AddSize.size5),
//                         border: Border.all(color: curreentIndex.value == index ? AppTheme.primaryColor : Colors.transparent,width: AddSize.size10*.22)
//                       ),
//                       child: ListTile(
//                         visualDensity: VisualDensity(horizontal: -4, vertical: 0),
//                         leading: Icon(Icons.favorite_border,color: AppTheme.blackColor,),
//                         title: Text(
//                           "Nope: its new to me",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               color: AppTheme.blackColor,
//                               fontSize: AddSize.font12),
//                         ),
//                         trailing: AnimatedContainer(
//                           duration: Duration(seconds: 20),
//                           child: Icon(Icons.check,color: AppTheme.primaryColor,size: curreentIndex.value == index
//                                 ? AddSize.size20 : 0,),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
// }),)
//           ],
//         ),
//       ),
//     );
//   }
}


