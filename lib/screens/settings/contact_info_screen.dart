// import 'package:country_calling_code_picker/country.dart';
// import 'package:country_calling_code_picker/country_code_picker.dart';
// import 'package:country_calling_code_picker/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/contact_info_controller.dart';
import '../../controller/profie_screen_controller.dart';
import '../../models/model_countrylist.dart';
import '../../popups/radio_buttons_contact_info.dart';
import '../../repository/countrylist_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/box_textfield.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({Key? key}) : super(key: key);

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  var editContact = false;
  var editProfile = false;

  // Country? _selectedCountry;
  var countryText = false;

  @override
  void initState() {
    // initCountry();
    super.initState();
    countryListRepo().then((value) => setState(() {
          countryList = value;
          countryList1.addAll(value.countrylist!);
        }));
    controller.getData();
    controller.getTimezoneList();

  }

  // void initCountry() async {
  //   final country = await getDefaultCountry(context);
  //   setState(() {
  //     _selectedCountry = country;
  //   });
  // }
  //
  // void _onPressedShowBottomSheet() async {
  //   final country = await showCountryPickerSheet(
  //     context,
  //   );
  //   if (country != null) {
  //     setState(() {
  //       _selectedCountry = country;
  //     });
  //   }
  // }

  var selectedCountry;
  Map<String, String> searchList = {};

  ModelCountryList countryList = ModelCountryList();
  List<Countrylist> countryList1 = [];
  List<Countrylist> searchList1 = [];

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final profileController = Get.put(ProfileScreenController());
  final controller = Get.put(ContactInfoController());

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
                                      borderRadius: BorderRadius.circular(1000),
                                      child: profileController.status.value.isSuccess ?
                                      CachedNetworkImage(
                                        imageUrl: profileController.model.value.data!.basicInfo!.profileImage ?? "" ,
                                        errorWidget: (_,__,___) => SizedBox(),
                                        placeholder: (_,__) => SizedBox(),
                                        fit: BoxFit.cover,
                                      ) : SizedBox(),
                                    ),),
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
                                            profileController.model.value.data!.basicInfo!.email.toString(),
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
                                      controller.statusOfReason.value.isSuccess
                                          ? showDialog(
                                              context: context,
                                              builder: (ctx) =>
                                                  RadioButtonsContactInfo())
                                          : controller
                                                  .statusOfReason.value.isError
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
                                                            size:
                                                                AddSize.size30,
                                                          ))
                                                    ],
                                                  ),
                                                )
                                              : Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: editContact == true
                          ? Column(
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
                                DropdownButtonFormField<dynamic>(
                                  isExpanded: true,
                                  menuMaxHeight: AddSize.screenHeight * .54,
                                  value: null,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select type';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Time zone",
                                    hintStyle: TextStyle(fontSize: 13, color: Color(0xff596681)),
                                    counterText: "",
                                    filled: true,
                                    fillColor:
                                    AppTheme.primaryColor.withOpacity(.05),
                                    focusColor:
                                    AppTheme.primaryColor.withOpacity(.05),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.primaryColor
                                            .withOpacity(.15),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
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
                                        value:  controller.timezoneList.data![index],
                                        child: Text(
                                          controller.timezoneList.data![index].timezone.toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xff596681)),
                                        ),
                                      )),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (newValue) {},
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
                                InkWell(
                                    onTap: () {
                                      // countryListRepo().then((value) => print(value));
                                      countryText = true;
                                      searchList1 = countryList1;
                                      // searchList = countryList;
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
                                                      color:
                                                          AppTheme.blackColor,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(10)
                                                      .copyWith(top: 0),
                                                  child: TextFormField(
                                                    onChanged: (String value) {
                                                      if (value.isNotEmpty) {
                                                        setState(() {
                                                          searchList1 = countryList1
                                                              .where((element) => element
                                                                  .name!
                                                                  .toLowerCase()
                                                                  .contains(value
                                                                      .toLowerCase()))
                                                              .toList();
                                                        });
                                                      } else if (value == "") {
                                                        setState(() {
                                                          searchList1 =
                                                              countryList1;
                                                        });
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: AppTheme
                                                          .primaryColor
                                                          .withOpacity(.05),
                                                      hintText:
                                                          "Select country",
                                                      prefixIcon:
                                                          Icon(Icons.flag),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color: Color(
                                                                  0xff596681),
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
                                                                .withOpacity(
                                                                    .15),
                                                            width: 1.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppTheme
                                                                .primaryColor
                                                                .withOpacity(
                                                                    .15),
                                                            width: 1.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
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
                                                                  .circular(
                                                                      8.0)),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          searchList1.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedCountry =
                                                                  searchList1[
                                                                          index]
                                                                      .name
                                                                      .toString();
                                                            });
                                                            print(searchList1[
                                                                    index]
                                                                .name
                                                                .toString());
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
                                                                    .name
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              )),
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: countryText == false
                                        ? TextFormField(
                                            enabled: false,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppTheme.primaryColor
                                                  .withOpacity(.05),
                                              hintText: "Select country",
                                              errorText: "Select country",
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
                                                    BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppTheme.primaryColor
                                                        .withOpacity(.15),
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppTheme
                                                          .primaryColor
                                                          .withOpacity(.15),
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                          )
                                        : TextFormField(
                                            enabled: false,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppTheme.primaryColor
                                                  .withOpacity(.05),
                                              hintText: '${selectedCountry}',
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
                                                    BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppTheme.primaryColor
                                                        .withOpacity(.15),
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppTheme
                                                          .primaryColor
                                                          .withOpacity(.15),
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                          )),
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
                                              editContact = false;
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

                                Text(
                                  "Time Zone",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "UTC+05:30 Mumbai, Kolkata, Chennai, New Delhi",
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
                                Text(
                                  "Phone",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "+91 98-76-54-3210",
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
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff393939)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "India",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.settingsTextColor),
                                ),
                              ],
                            )),
                ],
              ),
            ),
          );
        }));
  }
}
