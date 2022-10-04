import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/app_theme.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_textfield.dart';

class AddTestimonialsScreen extends StatefulWidget {
  const AddTestimonialsScreen({Key? key}) : super(key: key);

  @override
  State<AddTestimonialsScreen> createState() => _AddTestimonialsScreenState();
}

class _AddTestimonialsScreenState extends State<AddTestimonialsScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _projectController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Add Testimonials",
          // onPressedForLeading:,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Client Title",
                  style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                    controller: _titleController,
                    obSecure: false.obs,
                    keyboardType: TextInputType.datetime,
                    hintText: "Ex. Direct of marketing".obs),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Project Type",
                  style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                    controller: _projectController,
                    obSecure: false.obs,
                    keyboardType: TextInputType.text,
                    hintText: "Ex.Marketing brand refresh".obs),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Message to client 0/800",
                  style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                    controller: _messageController,
                    obSecure: false.obs,
                    keyboardType: TextInputType.text,
                    hintText:
                        "Lorem ipsum is simply dummy text of the printing and typesetting industry. lorem ipsum has been the industry"
                            .obs,
                    isMulti: true),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomOutlineButton(
            title: 'Request Testimonial',
            backgroundColor: AppTheme.primaryColor,
            onPressed: () {},
            textColor: AppTheme.whiteColor,
            expandedValue: false,
          ),
        ),
      ),
    );
  }
}
