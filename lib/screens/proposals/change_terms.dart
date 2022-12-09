import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/resources/size.dart';

import '../../Controller/jobs_detail_controller.dart';
import '../../models/model_milestones.dart';
import '../../popups/radio_buttons_job_details.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class ChangeTermsScreen extends StatefulWidget {
  const ChangeTermsScreen({Key? key}) : super(key: key);

  @override
  State<ChangeTermsScreen> createState() =>
      _ChangeTermsScreenState();
}

class _ChangeTermsScreenState extends State<ChangeTermsScreen> {
  String? radioProjectType = "By project";
  final dateFormatForShow = DateFormat('yyyy-MM-dd');
  final controller = Get.put(JobsDetailController());
  List<ModelMilestones> milestone = <ModelMilestones>[
    ModelMilestones(description: "", amount: "", dueDate: "")
  ];
  dynamic dateInput = 0;

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
        body: SingleChildScrollView(
            child: Column(
          children: [
            contentSection(),
            coverLetter(),
            Message(),
            AboutTheClient(),
          ],
        )));
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
            "Mobile App And Website design",
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
                title: "Backend Developer",
                backgroundColor: AppTheme.whiteColor,
                textColor: AppTheme.primaryColor,
                onPressed: () {},
              ),
              SizedBox(
                width: AddSize.size10,
              ),
              Text(
                'Posted dec 6, 2022',
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
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font14,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: AddSize.size20,
          ),
          Text(
            "View job posting",
            style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
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
            "Client's budget: \$70.00",
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
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
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
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
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
          Text(
            "How many milestones do you want to include?",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: milestone.length,
              itemBuilder: (context, index) {
                print(milestone.length);
                print(milestone);
                return mileStones(deviceHeight, index, milestone[index]);
              }),
          SizedBox(
            height: deviceHeight * .03,
          ),
          InkWell(
            onTap: () {
              setState(() {
                milestone.add(
                    ModelMilestones(description: "", amount: "", dueDate: ""));
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
          Text(
            "\$0.00",
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
          Text(
            "\$0.00",
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
          Text(
            "\$0.00",
            style: TextStyle(
                color: AppTheme.darkBlueText,
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
          ),
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
                builder:
                    (BuildContext context) {
                  return RadioButtonsJobDetails();
                },
              );
            },
            readOnly: true,
            controller: controller.durationController,
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10),
              border: new OutlineInputBorder(
                borderRadius:
                new BorderRadius.circular(
                    5.0),
                borderSide: new BorderSide(
                    color:
                    AppTheme.primaryColor),
              ),
              hintText: "Select a duration",
              focusColor: AppTheme.primaryColor,
              suffixIcon: Icon(Icons
                  .keyboard_arrow_down_outlined),
              hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                  AppTheme.hintTextColor),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                new BorderRadius.circular(
                    5.0),
                borderSide: new BorderSide(
                    color:
                    AppTheme.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                new BorderRadius.circular(
                    5.0),
                borderSide: new BorderSide(
                    color:
                    AppTheme.primaryColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius:
                new BorderRadius.circular(
                    5.0),
                borderSide: new BorderSide(
                    color:
                    AppTheme.primaryColor),
              ),
            ),
            validator: MultiValidator([
              RequiredValidator(
                  errorText:
                  'Select a duration'),
            ]),
          ),
          SizedBox(
            height: AddSize.size30,
          ),
          CustomOutlineButton(title: "Submit", backgroundColor: AppTheme.primaryColor,
          textColor: AppTheme.whiteColor,expandedValue: true,onPressed: (){},),
          SizedBox(
            height: AddSize.size20,
          ),
          CustomOutlineButton(title: "Cancel", backgroundColor:AppTheme.whiteColor,
            textColor:  AppTheme.primaryColor,expandedValue: true,onPressed: (){},)

        ]));
  }





  Column mileStones(double deviceHeight, int index, listIndex) {
    final TextEditingController _descriptionController =
        TextEditingController();
    final TextEditingController _dueDateController = TextEditingController();
    final TextEditingController _amountController = TextEditingController();

    /*   Map map = <String,dynamic>{};
    map["description"] = _descriptionController.text;
    map["Due date"] = _dueDateController.text;
    map["amount"] = _amountController.text;*/
    // milestone.contains(index,ModelMilestones(description: _descriptionController.text.trim() ,amount: _amountController.text.trim(),dueDate:_dueDateController.text.trim()));
    _descriptionController.text = milestone[index].description.toString();
    _dueDateController.text = milestone[index].dueDate.toString();
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
                        _dueDateController.text =
                            dateFormatForShow.format(pickedDate);
                        print(pickedDate.millisecondsSinceEpoch);
                        setState(() {
                          dateInput = _dueDateController.text;
                          milestone[index].dueDate = dateInput.toString();
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
                    onChanged: (value) {
                      milestone[index].dueDate = value.toString();
                    },
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
    )],
    ),
      child:  Theme(
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
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's.",
                  style: TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ]),
        ),
      ) ,
    );
  }

  Message(){
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
          )],
      ),
      child:  Theme(
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
                  style: TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ]),
        ),
      ) ,
    );
  }

  AboutTheClient(){
    return Container(
      margin: const EdgeInsets.only(right: 12,left: 12,bottom: 15),
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
          )],
      ),
      child:  Theme(
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
                        color:AppTheme.primaryColor, size: 20),
                    SizedBox(
                      width: AddSize.size10,
                    ),
                    Text(
                     "Payment method verified",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        color: Color(0xff4D4D4D),),
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
                              (index) => 3 > index
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
                      "4.2 of 22 reviews",
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
                         "Netherlands",
                         style: TextStyle(
                           fontSize: AddSize.font16,
                           fontWeight: FontWeight.w600,
                           color: AppTheme.primaryColor,),
                       ),
                       SizedBox(
                         height: AddSize.size5,
                       ),
                       Text(
                         "Zwijndrecht 12:20 pm",
                         style: TextStyle(
                           fontSize: AddSize.font16,
                           fontWeight: FontWeight.w500,
                           color: Color(0xff462D7A),),
                       ),
                       SizedBox(
                         height: AddSize.size10,
                       ),
                       Text(
                         "5 jobs posted",
                         style: TextStyle(
                           fontSize: AddSize.font16,
                           fontWeight: FontWeight.w600,
                           color: AppTheme.primaryColor,),
                       ),
                       SizedBox(
                         height: AddSize.size5,
                       ),
                       Text(
                         "20% hire rate, 1 open job",
                         style: TextStyle(
                           fontSize: AddSize.font16,
                           fontWeight: FontWeight.w500,
                           color: Color(0xff462D7A),),
                       ),
                       SizedBox(
                         height: AddSize.size10,
                       ),
                       Text(
                         "\$300+ total spent",
                         style: TextStyle(
                           fontSize: AddSize.font16,
                           fontWeight: FontWeight.w600,
                           color: AppTheme.primaryColor,),
                       ),
                       SizedBox(
                         height: AddSize.size5,
                       ),
                       Text(
                         "5 hires, 2 active",
                         style: TextStyle(
                           fontSize: AddSize.font16,
                           fontWeight: FontWeight.w500,
                           color: Color(0xff462D7A),),
                       ),
                       SizedBox(
                         height: AddSize.size10,
                       ),
                       Text(
                         "1 to 3 months",
                         style: TextStyle(
                           fontSize: AddSize.font16,
                           fontWeight: FontWeight.w600,
                           color: AppTheme.primaryColor,),
                       ),
                       SizedBox(
                         height: AddSize.size5,
                       ),
                       Text(
                         "Project Length",
                         style: TextStyle(
                           fontSize: AddSize.font16,
                           fontWeight: FontWeight.w500,
                           color: Color(0xff462D7A),),
                       ),
                       SizedBox(
                         height: AddSize.size15,
                       ),
                       Text(
                         "Mid size company (10-99 people)",
                         style: TextStyle(
                           fontSize: AddSize.font16,
                           fontWeight: FontWeight.w500,
                           color: Color(0xff462D7A),),
                       ),
                       SizedBox(
                         height: AddSize.size15,
                       ),
                       Text(
                         "Member since Sep 16, 2020",
                         style: TextStyle(
                           fontSize: AddSize.font16,
                           fontWeight: FontWeight.w500,
                           color: Color(0xff462D7A),),
                       ),

                     ],
                   ),
                 ],
               )
              ]),
        ),
      ) ,
    );
  }

}
