import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../resources/app_theme.dart';
import '../../widgets/box_textfield.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class TaxInformationScreen extends StatefulWidget {
  const TaxInformationScreen({Key? key}) : super(key: key);

  @override
  State<TaxInformationScreen> createState() => _TaxInformationScreenState();
}

class _TaxInformationScreenState extends State<TaxInformationScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController taxpayerNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateInput.text = ""; //set the initial value of text field
    initCountry();
  }

  var editTax = false;
  var editGST = false;
  var haveGST = false;
  var editBEN = false;
  var edit9BEN = false;

  String? gst;
  String? usPerson;
  String? taxPayerNumber;

  Country? _selectedCountry;
  var countryText = false;

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }

  void _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  bool acceptTermsOrPrivacy = false;

  var federalTaxClassification = [
    "Individual/sole proprietor or single-member LLC",
    "Limited liability company",
    "c Corporation",
    "S Corporation",
    "Partnership",
    "Trust/estate",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    final country = _selectedCountry;
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Tax Information",
            // onPressedForLeading:,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tax Residence",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            editTax = true;
                          }),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.whiteColor,
                                border: Border.all(color: Color(0xff707070))),
                            child: Icon(
                              Icons.add,
                              color: AppTheme.primaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "This address will be displayed on invoices.",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: AppTheme.settingsTextColor.withOpacity(.63)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                        child: editTax == true
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Country ",
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
                                        _onPressedShowBottomSheet();
                                        setState(() {
                                          countryText = true;
                                        });
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
                                                /* prefixIcon: Icon(Icons.flag),*/
                                                hintStyle: const TextStyle(
                                                    color: Color(0xff596681),
                                                    fontSize: 15),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 14,
                                                        horizontal: 20),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppTheme.primaryColor.withOpacity(.15),
                                                      width: 1.0
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppTheme
                                                          .primaryColor
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
                                                hintText: ' ${country!.name}',
                                                errorText: "Select country",
                                                /*prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Image.asset(
                                                country.flag,
                                                package: countryCodePackageName,
                                                width: 5,
                                                height: 5,
                                              ),
                                            ),*/
                                                hintStyle: const TextStyle(
                                                    color: Color(0xff596681),
                                                    fontSize: 15),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
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
                                                      BorderRadius.circular(8),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppTheme
                                                          .primaryColor
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
                                  Divider(
                                    color:
                                        AppTheme.primaryColor.withOpacity(.49),
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
                                    color:
                                        AppTheme.primaryColor.withOpacity(.49),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Postal Code",
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
                                    controller: postalController,
                                    hintText: "Postal Code".obs,
                                    keyboardType: TextInputType.number,
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
                                            backgroundColor:
                                                AppTheme.whiteColor,
                                            onPressed: () {
                                              setState(() {
                                                editTax = false;
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
                                children: [
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.textColor),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "-",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textColor),
                                  ),
                                ],
                              ))
                  ],
                ),
              ),
              /*   Container(
                margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tax Identification (ID)",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.whiteColor,
                              border: Border.all(color: Color(0xff707070))),
                          child: Icon(
                            Icons.add,
                            color: AppTheme.primaryColor,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "A Permanent Account Number (PAN) is requested from all person located in india.",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: AppTheme.settingsTextColor.withOpacity(.63)),
                    ),
                  ],
                ),
              ),*/
              Container(
                margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "GSTIN",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            editGST = true;
                          }),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.whiteColor,
                                border: Border.all(color: Color(0xff707070))),
                            child: Icon(
                              Icons.add,
                              color: AppTheme.primaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "A Goods and Services Tax Identification Number is requested from all person located in a country where Unify supports GSTIN.",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: AppTheme.settingsTextColor.withOpacity(.63)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                        child: editGST == true
                            ? Column(
                                children: [
                                  RadioListTile(
                                    title: Text(
                                      "I am not registered for a GSTIN",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.settingsTextColor),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    value: "No",
                                    groupValue: gst,
                                    onChanged: (value) {
                                      setState(() {
                                        gst = value.toString();
                                        haveGST = false;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text(
                                      "I am registered for a GSTIN",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.settingsTextColor),
                                    ),
                                    contentPadding: const EdgeInsets.all(0),
                                    dense: true,
                                    visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    value: "Yes",
                                    groupValue: gst,
                                    onChanged: (value) {
                                      setState(() {
                                        gst = value.toString();
                                        haveGST = true;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                      child: haveGST == true
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "GSTIN",
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color(0xff393939)),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                BoxTextField(
                                                  obSecure: false.obs,
                                                  controller: addressController,
                                                  hintText:
                                                      "Enter 15- digits ID number here"
                                                          .obs,
                                                  keyboardType: TextInputType
                                                      .streetAddress,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Divider(
                                                  color: AppTheme.primaryColor
                                                      .withOpacity(.49),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  "Registration Date",
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color(0xff393939)),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                TextFormField(
                                                  controller: dateInput,
                                                  decoration: InputDecoration(
                                                    suffixIcon: InkWell(
                                                      onTap: () async {
                                                        DateTime? pickedDate =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime(
                                                                        1950),
                                                                //DateTime.now() - not to allow to choose before today.
                                                                lastDate:
                                                                    DateTime(
                                                                        2100));

                                                        if (pickedDate !=
                                                            null) {
                                                          print(
                                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                          String formattedDate =
                                                              DateFormat(
                                                                      'MMMM d,y')
                                                                  .format(
                                                                      pickedDate);
                                                          print(
                                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                                          setState(() {
                                                            dateInput.text =
                                                                formattedDate; //set output date to TextField value.
                                                          });
                                                        } else {}
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        color: AppTheme
                                                            .primaryColor,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    filled: true,
                                                    fillColor: AppTheme
                                                        .primaryColor
                                                        .withOpacity(.05),
                                                    hintText: "MMMM d,y",
                                                    labelStyle: const TextStyle(
                                                        color: Colors.black),
                                                    hintStyle: const TextStyle(
                                                        color:
                                                            Color(0xff596681),
                                                        fontSize: 15),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            right: 0,
                                                            left: 10,
                                                            top: 14,
                                                            bottom: 14),
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

                                                    // enabledBorder: textFieldfocused(),
                                                    // border: textFieldfocused(),
                                                    // focusedBorder: textFieldfocused(),
                                                    // errorBorder: errorrTextFieldBorder(),
                                                    // focusedErrorBorder: errorrTextFieldBorder(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child:
                                                            CustomOutlineButton(
                                                          title: 'Update',
                                                          backgroundColor:
                                                              AppTheme
                                                                  .primaryColor,
                                                          onPressed: () {},
                                                          expandedValue: false,
                                                          textColor: AppTheme
                                                              .whiteColor,
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child:
                                                            CustomOutlineButton(
                                                          title: 'cancel',
                                                          backgroundColor:
                                                              AppTheme
                                                                  .whiteColor,
                                                          onPressed: () {
                                                            setState(() {
                                                              editGST = false;
                                                            });
                                                          },
                                                          expandedValue: false,
                                                          textColor: AppTheme
                                                              .primaryColor,
                                                        )),
                                                  ],
                                                )
                                              ],
                                            )
                                          : SizedBox())
                                ],
                              )
                            : SizedBox())
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          edit9BEN == true ? "W-9" : "W-8BEN",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            editBEN = true;
                          }),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.whiteColor,
                                border: Border.all(color: Color(0xff707070))),
                            child: Icon(
                              Icons.add,
                              color: AppTheme.primaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      child: editBEN == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text:
                                          "To collect the right information , indicate if you are a ",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: AppTheme.settingsTextColor
                                              .withOpacity(.63)),
                                      children: [
                                        TextSpan(
                                          text: "U.S. person :",
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              color: AppTheme.primaryColor),
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                RadioListTile(
                                  title: Text(
                                    "I am not a U.S. person",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.settingsTextColor),
                                  ),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  value: "No",
                                  groupValue: usPerson,
                                  onChanged: (value) {
                                    setState(() {
                                      usPerson = value.toString();
                                      edit9BEN = false;
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: Text(
                                    "I am a U.S. person ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.settingsTextColor),
                                  ),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                  visualDensity: const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  value: "Yes",
                                  groupValue: usPerson,
                                  onChanged: (value) {
                                    setState(() {
                                      usPerson = value.toString();
                                      edit9BEN = true;
                                    });
                                  },
                                ),
                                SizedBox(
                                    child: edit9BEN == true
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Text(
                                                "Before withdrawing funds, all non U.S. persons must provide their W-9 tax information.",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: AppTheme.textColor),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text(
                                                "Legal Name of Taxpayer",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppTheme.textColor),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              BoxTextField(
                                                obSecure: false.obs,
                                                controller: nameController,
                                                hintText: "Name".obs,
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                "Federal Tax Classification",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppTheme.textColor),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              DropdownButtonFormField<dynamic>(
                                                isExpanded: true,
                                                value: null,
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select type';
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Please select",
                                                  hintStyle: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff596681)),
                                                  counterText: "",
                                                  filled: true,
                                                  fillColor: AppTheme
                                                      .primaryColor
                                                      .withOpacity(.05),
                                                  focusColor: AppTheme
                                                      .primaryColor
                                                      .withOpacity(.05),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 8,
                                                    vertical: 14,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: AppTheme
                                                          .primaryColor
                                                          .withOpacity(.15),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: AppTheme
                                                                .primaryColor
                                                                .withOpacity(
                                                                    .15),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppTheme
                                                              .primaryColor
                                                              .withOpacity(.15),
                                                          width: 2.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                ),
                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color:
                                                        AppTheme.primaryColor),
                                                items: List.generate(
                                                    federalTaxClassification
                                                        .length,
                                                    (index) => DropdownMenuItem(
                                                          value:
                                                              federalTaxClassification[
                                                                  index],
                                                          child: Text(
                                                            federalTaxClassification[
                                                                    index]
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Color(
                                                                    0xff596681)),
                                                          ),
                                                        )),
                                                // After selecting the desired option,it will
                                                // change button value to selected value
                                                onChanged: (newValue) {},
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Text(
                                                "Taxpayer Identification Number Type",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppTheme.textColor),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              RadioListTile(
                                                title: Text(
                                                  "Social Security Number (SSN)",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppTheme
                                                          .settingsTextColor),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                dense: true,
                                                visualDensity: VisualDensity(
                                                    horizontal: -4,
                                                    vertical: -4),
                                                value: "SSN",
                                                groupValue: taxPayerNumber,
                                                onChanged: (value) {
                                                  setState(() {
                                                    taxPayerNumber =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              RadioListTile(
                                                title: Text(
                                                  "Employer Identification Number (EIN)",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppTheme
                                                          .settingsTextColor),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                dense: true,
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: -4,
                                                        vertical: -4),
                                                value: "EIN",
                                                groupValue: gst,
                                                onChanged: (value) {
                                                  setState(() {
                                                    taxPayerNumber =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Text(
                                                "SSN/EIN #",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppTheme.textColor),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              BoxTextField(
                                                obSecure: false.obs,
                                                controller: taxpayerNumberController,
                                                hintText: "".obs,
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Checkbox(
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      value:
                                                          acceptTermsOrPrivacy,
                                                      activeColor:
                                                          AppTheme.primaryColor,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          acceptTermsOrPrivacy =
                                                              newValue!;
                                                        });
                                                      }),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                            color: AppTheme
                                                                .primaryColor,
                                                            fontSize: 10),
                                                        children: [
                                                          const TextSpan(
                                                            text:
                                                                'Yes, I certify, under penalties of perjury, That the representations in this ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff172B4D),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          const TextSpan(
                                                            text:
                                                                'Tax Certificate',
                                                            style: TextStyle(
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          const TextSpan(
                                                            text:
                                                                " are true and correct.",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff172B4D),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child:
                                                          CustomOutlineButton(
                                                        title: 'Update',
                                                        backgroundColor:
                                                            AppTheme
                                                                .primaryColor,
                                                        onPressed: () {},
                                                        expandedValue: false,
                                                        textColor:
                                                            AppTheme.whiteColor,
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child:
                                                          CustomOutlineButton(
                                                        title: 'cancel',
                                                        backgroundColor:
                                                            AppTheme.whiteColor,
                                                        onPressed: () {
                                                          setState(() {
                                                            editBEN = false;
                                                          });
                                                        },
                                                        expandedValue: false,
                                                        textColor: AppTheme
                                                            .primaryColor,
                                                      )),
                                                ],
                                              )
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Text(
                                                "Before withdrawing funds, all non-U.S persons must provide their W8-BEN Tax Information",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: AppTheme.textColor),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text(
                                                "Legal Name of Taxpayer",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppTheme.textColor),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              BoxTextField(
                                                obSecure: false.obs,
                                                controller: nameController,
                                                hintText: "Name".obs,
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                "Provide the same name as shown as on your tax return",
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: AppTheme.textColor),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Checkbox(
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      value:
                                                          acceptTermsOrPrivacy,
                                                      activeColor:
                                                          AppTheme.primaryColor,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          acceptTermsOrPrivacy =
                                                              newValue!;
                                                        });
                                                      }),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                            color: AppTheme
                                                                .primaryColor,
                                                            fontSize: 10),
                                                        children: [
                                                          const TextSpan(
                                                            text:
                                                                'Yes, I certify, under penalties of perjury, That the representations in this ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff172B4D),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          const TextSpan(
                                                            text:
                                                                'Tax Certificate',
                                                            style: TextStyle(
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          const TextSpan(
                                                            text:
                                                                " are true and correct.",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff172B4D),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child:
                                                          CustomOutlineButton(
                                                        title: 'Update',
                                                        backgroundColor:
                                                            AppTheme
                                                                .primaryColor,
                                                        onPressed: () {},
                                                        expandedValue: false,
                                                        textColor:
                                                            AppTheme.whiteColor,
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child:
                                                          CustomOutlineButton(
                                                        title: 'cancel',
                                                        backgroundColor:
                                                            AppTheme.whiteColor,
                                                        onPressed: () {
                                                          setState(() {
                                                            editBEN = false;
                                                          });
                                                        },
                                                        expandedValue: false,
                                                        textColor: AppTheme
                                                            .primaryColor,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ))
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Before withdrawing funds, all non-U.S. person must provide their W-8BEN tax information.",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppTheme.settingsTextColor
                                          .withOpacity(.63)),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  "Legal Name of Taxpayer",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textColor),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textColor),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Federal Tax Classification",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textColor),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textColor),
                                ),
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class PickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountryPickerWidget(
      onSelected: (country) => Navigator.pop(context, country),
    );
  }
}
