import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/controller/proposals_screen_controller.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/resources/size.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import '../../models/proposals/model_submitted_proposal.dart';
import '../../repository/proposals/submitted_proposal_repository.dart';
import '../../repository/proposals/withdraw_proposal_repository.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/progress_indicator.dart';

class SubmittedProposalScreen extends StatefulWidget {
  const SubmittedProposalScreen({Key? key}) : super(key: key);

  @override
  State<SubmittedProposalScreen> createState() =>
      _SubmittedProposalScreenState();
}

class _SubmittedProposalScreenState extends State<SubmittedProposalScreen> {
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
    submittedRepo(id,type).then((value) {
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();

       if(model.value.data!.milestonedata!.isNotEmpty) {
         for (int i = 0; i < model.value.data!.milestonedata!.length; i++) {
           milestonePrice = milestonePrice +
               int.parse(model.value.data!.milestonedata![i].amount.toString());
           print("milestone total price" + milestonePrice.toString());
         }
       }
      } else {
        showToast(value.message.toString());
        status.value = RxStatus.error();
      }
    });
  }
  
  int milestonePrice = 0;
 // int totalPrice = 0;

final controller = Get.put(ProposalScreenController());


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
              titleText: "Job details",
            )),
        body: Obx(() {
          return status.value.isSuccess
              ? SingleChildScrollView(
                  child: Column(
                  children: [
                    contentSection(),
                    coverLetter(),
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
        child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            onTap: (){
              Get.toNamed(MyRouter.jobDetailsScreen,arguments: [model.value.data!.projectData!.id.toString()]);
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
          Text(
            "By ${model.value.data!.projectData!.budgetType.toString().toLowerCase() == "fixed" ? "project" : "hourly"}",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font14,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: deviceHeight * .015,
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
          if(model.value.data!.projectData!.budgetType.toString().toLowerCase() == "fixed" && model.value.data!.milestonedata!.isNotEmpty)
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
          
          if(int.parse(model.value.data!.proposalData!.bidAmount.toString()) != 0)
          Text(
            "\$${model.value.data!.proposalData!.bidAmount.toString()}",
            style: TextStyle(
                color: AppTheme.darkBlueText,
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
          ),
          if(int.parse(model.value.data!.proposalData!.bidAmount.toString()) == 0)
            Text(
              "\$${milestonePrice}",
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
          if(int.parse(model.value.data!.proposalData!.bidAmount.toString()) != 0)
            Text(
              "\$${(int.parse(model.value.data!.proposalData!.bidAmount.toString()) - int.parse(model.value.data!.proposalData!.bidAmount.toString()) *
                  int.parse(model.value.data!.projectData!.serviceFee.toString()) / 100
              ).toString()}",
              style: TextStyle(
                  color: AppTheme.darkBlueText,
                  fontSize: AddSize.font16,
                  fontWeight: FontWeight.w600),
            ),
          if(int.parse(model.value.data!.proposalData!.bidAmount.toString()) == 0)
            Text("\$${(milestonePrice - milestonePrice *
                  int.parse(model.value.data!.projectData!.serviceFee.toString()) / 100
              ).toString()}",
              style: TextStyle(
                  color: AppTheme.darkBlueText,
                  fontSize: AddSize.font16,
                  fontWeight: FontWeight.w600),
            ),

          SizedBox(
            height: AddSize.size30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xff6D2EF1),
                    ),
                    backgroundColor: AppTheme.whiteColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    )),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                    Get.toNamed(MyRouter.changeTermsScreen , arguments: [id,"submit"]);
                },
                child: Text(
                  "Change terms",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppTheme.primaryColor,
                  ),
                ),
              )),
              SizedBox(
                width: AddSize.size10,
              ),
              Expanded(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xff6D2EF1),
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    )),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  withdrawProposal(context);
                },
                child: Text(
                  "Withdraw proposal",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppTheme.whiteColor,
                  ),
                ),
              )),
            ],
            // =======
            //             ],
          ),
        ]));
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

/*  Message() {
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


  withdrawProposal(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _reasonController = TextEditingController();
    final _messageController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.size100 * .4),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        "Withdraw Proposal",
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
                          CustomTextField(
                            controller: _reasonController,
                            obSecure: false.obs,
                            keyboardType: TextInputType.text,
                            hintText: "".obs,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Reason is required'),
                            ]),
                          ),
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
                                    onPressed: () {
                                      if(_formKey.currentState!.validate()){
                                        proposalWithdrawRepo(
                                            proposal_id: model.value.data!.proposalData!.id.toString(),
                                            reason: _reasonController.text.trim(),
                                            description: _messageController.text.trim(),
                                            context: context
                                        ).then((value) {
                                          if(value.status == true){
                                            Get.offAllNamed(MyRouter.bottomNavbar);
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
            ),
          );
        });
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
