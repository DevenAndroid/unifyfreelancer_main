import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/question_controller.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class Page5 extends StatefulWidget {
  Page5({Key? key}) : super(key: key);

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  RxBool acceptTermsOrPrivacy = false.obs;

  final controller = Get.put(QuestionController());

  final dateFormat = DateFormat('yyyy-MM-dd');

  showDialogue(){
    final TextEditingController companyController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController fromController = TextEditingController();
    final TextEditingController toController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    int dateInput = 0;
    int dateInput2 = 0;
    showDialog(context: context, builder: (context){
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: AddSize.padding16),
        child: Form(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(AddSize.size10),
                    margin: EdgeInsets.all(AddSize.size10),
                    decoration: BoxDecoration(
                      color: AppTheme.whiteColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AddSize.size10),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 3)),
                      ] // changes position of shadow
                      ,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Company",
                            style: TextStyle(
                                fontSize: AddSize.font14,
                                color: AppTheme.titleText,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: AddSize.size5,
                          ),
                          CustomTextField(
                            controller: companyController,
                            obSecure: false.obs,
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Ex: Unify".obs,
                            validator:  MultiValidator([
                              RequiredValidator(errorText: 'Company is required'),
                            ]),
                          ),
                          SizedBox(
                            height: AddSize.size15,
                          ),
                          Text(
                            "Location",
                            style: TextStyle(
                                fontSize: AddSize.font14,
                                color: AppTheme.titleText,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: AddSize.size5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: cityController,
                                  obSecure: false.obs,
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: "City".obs,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'city is required'),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                width: AddSize.size5,
                              ),
                              Expanded(
                                child: TextFormField(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus!.unfocus();
                                    controller.searchList1.clear();
                                    for (var item in controller.countryList.value.countrylist!) {
                                      controller.searchList1.add(item.name.toString());
                                    }
                                    showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(AddSize.size30),
                                              topRight: Radius.circular(AddSize.size30)
                                          )
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: MediaQuery.of(context).size.height * .7,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  icon: Icon(
                                                    Icons.clear,
                                                    color: AppTheme.blackColor,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(AddSize.size10)
                                                    .copyWith(top: 0),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (value != "") {
                                                      controller.searchList1.clear();
                                                      // searchList1.value = countryList.countrylist!.map((e) => e.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                                      for (var item in controller.countryList.value
                                                          .countrylist!) {
                                                        if (item.name
                                                            .toString()
                                                            .toLowerCase()
                                                            .contains(value
                                                            .toLowerCase())) {
                                                          controller.searchList1.add(
                                                              item.name.toString());
                                                        }
                                                      }
                                                    } else {
                                                      controller.searchList1.clear();
                                                      for (var item in controller.countryList.value
                                                          .countrylist!) {
                                                        controller.searchList1.add(
                                                            item.name.toString());
                                                      }
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: AppTheme.primaryColor
                                                        .withOpacity(.05),
                                                    hintText: "Select country",
                                                    prefixIcon: Icon(Icons.flag),
                                                    hintStyle: const TextStyle(
                                                        color: Color(0xff596681),
                                                        fontSize: 15),
                                                    contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 14,
                                                        horizontal: 20),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppTheme.primaryColor
                                                              .withOpacity(.15),
                                                          width: 1.0),
                                                      borderRadius:
                                                      BorderRadius.circular(AddSize.size10*.8),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppTheme.primaryColor
                                                              .withOpacity(.15),
                                                          width: 1.0),
                                                      borderRadius:
                                                      BorderRadius.circular(AddSize.size10*.8),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppTheme
                                                                .primaryColor
                                                                .withOpacity(.15),
                                                            width: 1.0),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            AddSize.size10*.8)),
                                                  ),
                                                ),
                                              ),
                                              Obx(() {
                                                return Expanded(
                                                  child: ListView.builder(
                                                      physics:
                                                      BouncingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: controller.searchList1.length,
                                                      itemBuilder: (context, index) {
                                                        return Obx(() {
                                                          return InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                countryController.text =
                                                                    controller.searchList1[index].toString();
                                                              });
                                                              print(countryController.text);
                                                              Navigator.pop(context);
                                                            },
                                                            child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    AddSize.size30,
                                                                    vertical: AddSize.size10),
                                                                child: Text(
                                                                  controller.searchList1[index]
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: AddSize.font14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                                )),
                                                          );
                                                        });
                                                      }),
                                                );
                                              }),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  readOnly: true,
                                  controller: countryController,
                                  decoration: InputDecoration(
                                    filled: true,

                                    fillColor: AppTheme.whiteColor,
                                    hintText: "Country",
                                    labelStyle: const TextStyle(color: Colors.black),
                                    suffixIcon:  Icon(Icons.keyboard_arrow_down),
                                    hintStyle: TextStyle(
                                      color: Color(0xff596681),
                                      fontSize: AddSize.size15,
                                    ),
                                    contentPadding: EdgeInsets.only(left: AddSize.size10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                                      borderRadius: BorderRadius.circular(AddSize.size10*.8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                                      borderRadius: BorderRadius.circular(AddSize.size10*.8),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                                        borderRadius: BorderRadius.circular(AddSize.size10*.8)),
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Country is required'),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AddSize.size15,
                          ),
                          Text(
                            "Title",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.titleText,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            controller: titleController,
                            obSecure: false.obs,
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Web developer".obs,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Title is required'),
                            ]),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Period",
                            style: TextStyle(
                                fontSize: AddSize.size14,
                                color: AppTheme.titleText,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: AddSize.size5,
                          ),
                          CustomTextField(
                            controller: fromController,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now());
                              if (pickedDate != null) {
                                print(pickedDate);
                                // String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                fromController.text = dateFormat.format(pickedDate);
                                print(pickedDate.millisecondsSinceEpoch);
                                setState(() {
                                  dateInput = pickedDate.millisecondsSinceEpoch;
                                });
                              } else {
                                return null;
                              }
                            },
                            obSecure: false.obs,
                            hintText: "Select Date".obs,
                            suffixIcon: Icon(
                              Icons.calendar_month_outlined,
                              size: AddSize.size22,
                              color: AppTheme.primaryColor,
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'From, date is required'),
                            ]),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: acceptTermsOrPrivacy.value,
                                  activeColor: AppTheme.primaryColor,
                                  onChanged: (newValue) {
                                    setState(() {
                                      acceptTermsOrPrivacy.value = newValue!;
                                      acceptTermsOrPrivacy.value == true ?  toController.text = "" : "controller.model.value.data!.employment![parentIndex].endDate.toString()";
                                    });
                                  }),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "I currently work here",
                                style: TextStyle(
                                    fontSize: AddSize.size12,
                                    color: AppTheme.titleText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: acceptTermsOrPrivacy == false
                                ? CustomTextField(
                              controller: toController,
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: dateInput2 == 0  ?DateTime.now() : DateTime.fromMicrosecondsSinceEpoch(dateInput2),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now());

                                if (pickedDate != null) {
                                  print(pickedDate);
                                  toController.text = dateFormat.format(pickedDate);
                                  setState(() {
                                    dateInput2 = pickedDate.millisecondsSinceEpoch; //set output date to TextField value.
                                  });
                                } else {}
                              },
                              obSecure: false.obs,
                              hintText: "To".obs,
                              suffixIcon: Icon(
                                Icons.calendar_month_outlined,
                                size: AddSize.size22,
                                color: AppTheme.primaryColor,
                              ),
                              /* validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'To, date is required'),
                            ]),*/
                            )
                                : SizedBox(),
                          ),
                          SizedBox(
                            height: AddSize.size15,
                          ),
                          Text(
                            "Description (Optional)",
                            style: TextStyle(
                                fontSize: AddSize.size14,
                                color: AppTheme.titleText,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: AddSize.size5,
                          ),
                          CustomTextField(
                            controller: descriptionController,
                            isMulti: true,
                            obSecure: false.obs,
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Description".obs,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Description is required'),
                            ]),
                          ),
                          SizedBox(
                            height: AddSize.size15,
                          ),
                        ])),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(AddSize.size10),
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
                        padding: EdgeInsets.all(AddSize.size10),
                        child: CustomOutlineButton(
                          title: 'Save',
                          backgroundColor: AppTheme.primaryColor,
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   editEmploymentInfoRepo(
                            //       id: parentIndex == -10000 ? parentIndex :
                            //       controller.model.value.data!.employment![parentIndex].id.toString(),
                            //       subject: _titleController.text.trim(),
                            //       description:
                            //       _descriptionController.text.trim(),
                            //       company: _companyController.text.trim(),
                            //       city: _cityController.text.trim(),
                            //       country: countryController.text.trim(),
                            //       start_date: _fromController.text.trim(),
                            //       end_date: _toController.text.trim(),
                            //       currently_working:
                            //       acceptTermsOrPrivacy == true ? 1 : 0,
                            //       context: context)
                            //       .then((value) {
                            //     if (value.status == true) {
                            //       Get.back();
                            //       controller.getData();
                            //     }
                            //     showToast(value.message.toString());
                            //   });
                            // }
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
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          padding: EdgeInsets.all(AddSize.size12),
          height: AddSize.screenHeight,
          width: AddSize.screenWidth,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AddSize.size10,
                ),
                Text(
                  "If you have relevant work experience, add it here",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "Freelancers who add their experience are twice as likely to win work. But if you're just starting out, you can still create a great profile. just head on the next page",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font12),
                ),
                SizedBox(
                  height: AddSize.size20,
                ),
                Container(
                  padding: EdgeInsets.all(AddSize.padding16),
                  decoration: BoxDecoration(
                      color: AppTheme.whiteColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Flutter developer",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textColor,
                                fontSize: AddSize.font18),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AddSize.size15),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(AddSize.size5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.whiteColor,
                                    border: Border.all(color: Color(0xff707070))),
                                child: Icon(
                                  Icons.edit,
                                  color: AppTheme.primaryColor,
                                  size: AddSize.size15,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.all(AddSize.size5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.whiteColor,
                                  border: Border.all(color: Color(0xff707070))),
                              child: Icon(
                                Icons.delete,
                                color: AppTheme.primaryColor,
                                size: AddSize.size15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AddSize.size20,
                      ),
                      Text(
                        "Eoxysit",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor,
                            fontSize: AddSize.font16),
                      ),
                      Text(
                        "November 2016 - Present",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppTheme.textColor,
                            fontSize: AddSize.font14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                CustomOutlineButton(
                  title: '+  Add Experience',
                  backgroundColor: AppTheme.whiteColor,
                  onPressed: () {
                    showDialogue();
                  },
                  textColor: AppTheme.primaryColor,
                  expandedValue: true,
                ),
                SizedBox(
                  height: AddSize.size20,
                ),
                Row(
                  children: [
                    Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: acceptTermsOrPrivacy.value,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (newValue) {
                          acceptTermsOrPrivacy.value = newValue!;
                          print(acceptTermsOrPrivacy.value);
                        }),
                    SizedBox(
                      width: AddSize.size5,
                    ),
                    Expanded(
                      child: Text(
                        "Nothing to Add? Check the box and keep going.",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textColor,
                            fontSize: AddSize.font14),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AddSize.size20,
                ),

              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: AddSize.padding16).copyWith(bottom: AddSize.padding14),
        child: Row(
          children: [
            Expanded(
              child: CustomOutlineButton(
                title: "Back",
                backgroundColor: AppTheme.whiteColor,
                textColor: AppTheme.primaryColor,
                expandedValue: false,
                onPressed: () {
                  controller.previousPage();
                },
              ),
            ),
            SizedBox(width: AddSize.size20,),
            Expanded(
              child: CustomOutlineButton(
                title: "Next",
                backgroundColor: AppTheme.primaryColor,
                textColor: AppTheme.whiteColor,
                expandedValue: false,
                onPressed: () {
                  controller.nextPage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
