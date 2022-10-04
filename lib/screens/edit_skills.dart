// import 'package:flutter/material.dart';
//
// import '../widgets/custom_appbar.dart';
//
// class EditSkillsScreen extends StatefulWidget {
//   const EditSkillsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<EditSkillsScreen> createState() => _EditSkillsScreenState();
// }
//
// class _EditSkillsScreenState extends State<EditSkillsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: const PreferredSize(
//           preferredSize: Size.fromHeight(kToolbarHeight),
//           child: CustomAppbar(
//             isLikeButton: false,
//             isProfileImage: false,
//             titleText: "Forgot Password",
//             // onPressedForLeading:,
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
//               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//               decoration: BoxDecoration(
//                 color: AppTheme.whiteColor,
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(5),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 4,
//                     offset: const Offset(0, 3), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Enter Email Address",
//                     style: TextStyle(
//                         color: AppTheme.textColor,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   BoxTextField(
//                       controller: emailController,
//                       obSecure: false.obs,
//                       hintText: "  Email ID".obs,
//                       validator: MultiValidator([
//                         RequiredValidator(
//                             errorText: 'username or email is required'),
//                         EmailValidator(errorText: 'enter a valid email address')
//                       ])),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   CommonButton("Send", () {
//                     if (_formKey.currentState!.validate()) {}
//                   }, deviceWidth, 50),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
