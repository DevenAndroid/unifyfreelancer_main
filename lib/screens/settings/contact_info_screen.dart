// import 'package:country_calling_code_picker/country.dart';
// import 'package:country_calling_code_picker/country_code_picker.dart';
// import 'package:country_calling_code_picker/functions.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../controller/contact_info_controller.dart';
import '../../controller/profie_screen_controller.dart';
import '../../models/model_countrylist.dart';
import '../../popups/radio_buttons_contact_info.dart';
import '../../repository/additional_account_repository.dart';
import '../../repository/countrylist_repository.dart';
import '../../repository/edit_location_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/box_textfield.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({Key? key}) : super(key: key);

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  bool editContact = false;
  bool editProfile = false;

  ModelCountryList countryList = ModelCountryList();
  RxList searchList1 = <String>[].obs;

  @override
  void initState() {
    // initCountry();
    super.initState();
    countryListRepo().then((value) => setState(() {
          countryList = value;
        }));
    controller.getData();
    controller.getTimezoneList();

    timezoneValue.value =
        fixStrings(profileController.model.value.data!.basicInfo!.timezone);
    phoneController.text =
        fixStrings(profileController.model.value.data!.basicInfo!.phone);
    addressController.text =
        fixStrings(profileController.model.value.data!.basicInfo!.address);
    zipController.text =
        fixStrings(profileController.model.value.data!.basicInfo!.zipCode);
    cityController.text =
        fixStrings(profileController.model.value.data!.basicInfo!.city);
    countryController.text =
        fixStrings(profileController.model.value.data!.basicInfo!.country);
  }

  String fixStrings(text) {
    return text.toString() == "" || text.toString() == "null"
        ? ""
        : text.toString();
  }

  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  final profileController = Get.put(ProfileScreenController());
  final controller = Get.put(ContactInfoController());

  RxString timezoneValue = "".obs;

  @override
  Widget build(BuildContext context) {
    // final country = _selectedCountry;
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Contact Info",
            // onPressedForLeading:,
          ),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor),
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          editProfile = true;
                        }),
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.whiteColor,
                              border: Border.all(color: Color(0xff707070))),
                          child: Icon(
                            Icons.edit,
                            color: AppTheme.primaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
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
                      child: editProfile == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "First name",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                BoxTextField(
                                  obSecure: false.obs,
                                  controller: fNameController,
                                  hintText: "First name".obs,
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Divider(
                                  color: AppTheme.primaryColor.withOpacity(.49),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Last name",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                BoxTextField(
                                  obSecure: false.obs,
                                  controller: lNameController,
                                  hintText: "Last name".obs,
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Divider(
                                  color: AppTheme.primaryColor.withOpacity(.49),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                BoxTextField(
                                  obSecure: false.obs,
                                  controller: emailController,
                                  hintText: "Email".obs,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: CustomOutlineButton(
                                          title: 'Update',
                                          backgroundColor:
                                              AppTheme.primaryColor,
                                          onPressed: () {},
                                          expandedValue: false,
                                          textColor: AppTheme.whiteColor,
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: CustomOutlineButton(
                                          title: 'cancel',
                                          backgroundColor: AppTheme.whiteColor,
                                          onPressed: () {
                                            setState(() {
                                              editProfile = false;
                                            });
                                          },
                                          expandedValue: false,
                                          textColor: AppTheme.primaryColor,
                                        )),
                                  ],
                                )
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /*    ListTile(
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1520635360276-79f3dbd809f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"))),
                        ),
                        title: Text(
                          "John Doe",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.greyTextColor2),
                        ),
                        subtitle: Text(
                          "johndoe123@gmail.com",
                          style: TextStyle(
                              fontSize: 14.sp, color: Color(0xff6B6B6B)),
                        ),
                        trailing: Text(
                          "f0ca1922",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff6B6B6B)),
                        ),
                      ),*/
                                Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        shape: BoxShape.circle,
                                        // image: DecorationImage(
                                        //     fit: BoxFit.cover,
                                        //     image: NetworkImage(
                                        //         "https://images.unsplash.com/photo-1520635360276-79f3dbd809f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"))),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        child: profileController
                                                .status.value.isSuccess
                                            ? CachedNetworkImage(
                                                imageUrl: profileController
                                                        .model
                                                        .value
                                                        .data!
                                                        .basicInfo!
                                                        .profileImage ??
                                                    "",
                                                errorWidget: (_, __, ___) =>
                                                    SizedBox(),
                                                placeholder: (_, __) =>
                                                    SizedBox(),
                                                fit: BoxFit.cover,
                                              )
                                            : SizedBox(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                profileController
                                                        .model
                                                        .value
                                                        .data!
                                                        .basicInfo!
                                                        .firstName
                                                        .toString() +
                                                    " " +
                                                    profileController
                                                        .model
                                                        .value
                                                        .data!
                                                        .basicInfo!
                                                        .lastName
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppTheme
                                                        .greyTextColor2),
                                              ),
                                              Text(
                                                "f0ca1922",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color(0xff6B6B6B)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            profileController.model.value.data!
                                                .basicInfo!.email
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Color(0xff6B6B6B)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomOutlineButton(
                                    title: ' Close My Account ',
                                    backgroundColor: AppTheme.whiteColor,
                                    expandedValue: false,
                                    textColor: AppTheme.primaryColor,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => controller
                                                  .statusOfReason
                                                  .value
                                                  .isSuccess
                                              ? RadioButtonsContactInfo()
                                              : controller.statusOfReason.value
                                                      .isError
                                                  ? SizedBox(
                                                      width: double.maxFinite,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                controller
                                                                    .getData();
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .change_circle_outlined,
                                                                size: AddSize
                                                                    .size30,
                                                              ))
                                                        ],
                                                      ),
                                                    )
                                                  : Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ));
                                    })
                              ],
                            )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Additional accounts",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Creating a new account allows you to use Unify in different ways, while still having just one login.",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: AppTheme.textColor.withOpacity(.63)),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.only(
                        right: 10, top: 10, left: 20, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppTheme.whiteColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Client Account",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Hire, manage and pay as a different company. Each client company has its own freelancers, payment methods and reports.",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: AppTheme.textColor.withOpacity(.63)),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomOutlineButton(
                          title: ' New Client Account ',
                          backgroundColor: AppTheme.whiteColor,
                          expandedValue: false,
                          textColor: AppTheme.primaryColor,
                          onPressed: () {
                            additionalAccountRepo("client", context)
                                .then((value) {
                              if (value.status == true) {}
                              showToast(value.message.toString());
                            });
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Agency Account",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Find jobs and earn money as manager of a team of freelancers.",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: AppTheme.textColor.withOpacity(.63)),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomOutlineButton(
                          title: ' New Agency Account ',
                          backgroundColor: AppTheme.whiteColor,
                          expandedValue: false,
                          textColor: AppTheme.primaryColor,
                          onPressed: () {
                            additionalAccountRepo("agency", context)
                                .then((value) {
                              if (value.status == true) {}
                              showToast(value.message.toString());
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor),
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          editContact = true;
                        }),
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.whiteColor,
                              border: Border.all(color: Color(0xff707070))),
                          child: Icon(
                            Icons.edit,
                            color: AppTheme.primaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10).copyWith(left: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppTheme.whiteColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
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
                    child: editContact == true
                        ? Form(
                            key: _formKey1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time Zone",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Obx(() {
                                  return DropdownButtonFormField<dynamic>(
                                    isExpanded: true,
                                    menuMaxHeight: AddSize.screenHeight * .54,
                                    value: timezoneValue.value == ""
                                        ? null
                                        : timezoneValue.value,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select type';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Time zone",
                                      hintStyle: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xff596681)),
                                      counterText: "",
                                      filled: true,
                                      fillColor: AppTheme.primaryColor
                                          .withOpacity(.05),
                                      focusColor: AppTheme.primaryColor
                                          .withOpacity(.05),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.primaryColor
                                              .withOpacity(.15),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppTheme.primaryColor
                                                .withOpacity(.15),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.primaryColor
                                                  .withOpacity(.15),
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down,
                                        color: AppTheme.primaryColor),
                                    items: List.generate(
                                        controller.timezoneList.data!.length,
                                        (index) => DropdownMenuItem(
                                              value: controller.timezoneList
                                                  .data![index].timezone
                                                  .toString(),
                                              child: Text(
                                                controller.timezoneList
                                                    .data![index].timezone
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff596681)),
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
                                      timezoneValue = newValue;
                                    },
                                  );
                                }),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Divider(
                                  color: AppTheme.primaryColor.withOpacity(.49),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Phone",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                BoxTextField(
                                  obSecure: false.obs,
                                  controller: phoneController,
                                  hintText: "Phone".obs,
                                  keyboardType: TextInputType.phone,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Phone is required'),
                                  ]),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Divider(
                                  color: AppTheme.primaryColor.withOpacity(.49),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Zip/Postal code",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                BoxTextField(
                                  obSecure: false.obs,
                                  controller: zipController,
                                  hintText: "Zip/Postal code".obs,
                                  keyboardType: TextInputType.number,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Zip is required'),
                                  ]),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Divider(
                                  color: AppTheme.primaryColor.withOpacity(.49),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                BoxTextField(
                                  obSecure: false.obs,
                                  controller: addressController,
                                  hintText: "Address".obs,
                                  keyboardType: TextInputType.streetAddress,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Address is required'),
                                  ]),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Divider(
                                  color: AppTheme.primaryColor.withOpacity(.49),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "City",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                BoxTextField(
                                  obSecure: false.obs,
                                  controller: cityController,
                                  hintText: "City".obs,
                                  keyboardType: TextInputType.text,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'City is required'),
                                  ]),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Divider(
                                  color: AppTheme.primaryColor.withOpacity(.49),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Select Country",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                    searchList1.clear();
                                    for (var item in countryList.countrylist!) {
                                      searchList1.add(item.name.toString());
                                    }
                                    showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .7,
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
                                                padding: EdgeInsets.all(10)
                                                    .copyWith(top: 0),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (value != "") {
                                                      searchList1.clear();
                                                      for (var item
                                                          in countryList
                                                              .countrylist!) {
                                                        if (item.name
                                                            .toString()
                                                            .toLowerCase()
                                                            .contains(value
                                                                .toLowerCase())) {
                                                          searchList1.add(item
                                                              .name
                                                              .toString());
                                                        }
                                                      }
                                                    } else {
                                                      searchList1.clear();
                                                      for (var item
                                                          in countryList
                                                              .countrylist!) {
                                                        searchList1.add(item
                                                            .name
                                                            .toString());
                                                      }
                                                    }
                                                    log("jsonEncode(searchList1)");
                                                  },
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: AppTheme
                                                        .primaryColor
                                                        .withOpacity(.05),
                                                    hintText: "Select country",
                                                    prefixIcon:
                                                        Icon(Icons.flag),
                                                    hintStyle: const TextStyle(
                                                        color:
                                                            Color(0xff596681),
                                                        fontSize: 15),
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 14,
                                                            horizontal: 20),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppTheme
                                                              .primaryColor
                                                              .withOpacity(.15),
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppTheme
                                                              .primaryColor
                                                              .withOpacity(.15),
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppTheme
                                                                .primaryColor
                                                                .withOpacity(
                                                                    .15),
                                                            width: 1.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0)),
                                                  ),
                                                ),
                                              ),
                                              Obx(() {
                                                return Expanded(
                                                  child: ListView.builder(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          searchList1.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Obx(() {
                                                          return InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                countryController
                                                                        .text =
                                                                    searchList1[
                                                                            index]
                                                                        .toString();
                                                              });
                                                              print(
                                                                  countryController
                                                                      .text);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            30,
                                                                        vertical:
                                                                            10),
                                                                child: Text(
                                                                  searchList1[
                                                                          index]
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
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
                                    fillColor:
                                        AppTheme.primaryColor.withOpacity(.05),
                                    hintText: 'Select country',
                                    prefixIcon: Icon(Icons.flag),
                                    suffixIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 20,
                                    ),
                                    hintStyle: const TextStyle(
                                        color: Color(0xff596681), fontSize: 15),
                                    contentPadding: const EdgeInsets.only(
                                        top: 14, bottom: 14, left: 20),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.primaryColor
                                              .withOpacity(.15),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.primaryColor
                                              .withOpacity(.15),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppTheme.primaryColor
                                                .withOpacity(.15),
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Country is required'),
                                  ]),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: CustomOutlineButton(
                                          title: 'cancel',
                                          backgroundColor: AppTheme.whiteColor,
                                          onPressed: () {
                                            setState(() {
                                              editContact = false;
                                            });
                                          },
                                          expandedValue: false,
                                          textColor: AppTheme.primaryColor,
                                        )),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: CustomOutlineButton(
                                          title: 'Update',
                                          backgroundColor:
                                              AppTheme.primaryColor,
                                          onPressed: () {
                                            if (_formKey1.currentState!
                                                .validate()) {
                                              editLocationRepo(
                                                      timezone:
                                                          timezoneValue.value,
                                                      phone: phoneController
                                                          .text
                                                          .trim(),
                                                      zip_code: zipController
                                                          .text
                                                          .trim(),
                                                      address: addressController
                                                          .text
                                                          .trim(),
                                                      city: cityController.text
                                                          .trim(),
                                                      country: countryController
                                                          .text
                                                          .trim(),
                                                      context: context)
                                                  .then((value) {
                                                print(jsonEncode(value));
                                                if (value.status == true) {
                                                  setState(() {
                                                    editContact == false;
                                                  });
                                                }
                                                showToast(
                                                    value.message.toString());
                                              });
                                            }
                                          },
                                          expandedValue: false,
                                          textColor: AppTheme.whiteColor,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Time Zone",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Color(0xff393939)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                profileController
                                        .model.value.data!.basicInfo!.timezone
                                        .toString()
                                        .isEmpty
                                    ? "-"
                                    : profileController
                                        .model.value.data!.basicInfo!.timezone
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.settingsTextColor),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                color: AppTheme.primaryColor.withOpacity(.49),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Phone",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Color(0xff393939)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                profileController
                                        .model.value.data!.basicInfo!.phone
                                        .toString()
                                        .isEmpty
                                    ? "-"
                                    : profileController
                                        .model.value.data!.basicInfo!.phone
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.settingsTextColor),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                color: AppTheme.primaryColor.withOpacity(.49),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Address",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Color(0xff393939)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                profileController
                                        .model.value.data!.basicInfo!.country
                                        .toString()
                                        .isEmpty
                                    ? "-"
                                    : profileController
                                        .model.value.data!.basicInfo!.country
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.settingsTextColor),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
