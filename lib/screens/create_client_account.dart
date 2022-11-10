import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';

import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';

class CreateClientAccount extends StatefulWidget {
  const CreateClientAccount({Key? key}) : super(key: key);

  @override
  State<CreateClientAccount> createState() => _CreateClientAccountState();
}

class _CreateClientAccountState extends State<CreateClientAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Create client account",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/Unify.png",height: 125,width: 125,),
          SizedBox(
            height: 20,
          ),
          Text(
            "Get our new app for clients!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppTheme.textColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "To give you the best unify experience possible we've released a new app dedicated for clients. Download it today to access all the feature our community of client use the most",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppTheme.textColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomOutlineButton(
          onPressed: () {},
          title: "Download Client App",
          backgroundColor: AppTheme.primaryColor,
          textColor: AppTheme.whiteColor,
        ),
      ),
    );
  }
}
