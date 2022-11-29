import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import '../../../resources/app_theme.dart';
import '../../repository/job_module/stripe_repository.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/custom_appbar.dart';
import '../../models/model_subscription.dart';

class StripPayment extends StatefulWidget {
  const StripPayment({Key? key}) : super(key: key);

  @override
  State<StripPayment> createState() => _StripPaymentState();
}

class _StripPaymentState extends State<StripPayment> {

  CardFormEditController controller =CardFormEditController();

  Data data = Data();

  @override
  void initState() {
    super.initState();
    if(Get.arguments != null){
      data = Get.arguments[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AddSize.size100 * .82),
        child: CustomAppbar(
          titleText: 'Payment',
          isLikeButton: false,
          isProfileImage: false,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text("Fill Card Details",
                  style: TextStyle(
                      fontSize: AddSize.size16,
                      fontWeight: FontWeight.w600),),
                const SizedBox(height: 10,),
                CardFormField(
                  controller: controller,
                  enablePostalCode: true,
                  autofocus: true,
                  style: CardFormStyle(
                      borderColor: Colors.black,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      placeholderColor: AppTheme.primaryColor,
                      textErrorColor: Colors.red,
                      fontSize: AddSize.padding16.toInt(),
                      cursorColor: Colors.redAccent,
                      borderRadius: 10,
                      borderWidth: 1),
                ),
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Subscription Amount: ${data.amount.toString()}",
                      style: TextStyle(
                          fontSize: AddSize.size16,
                          fontWeight: FontWeight.w500),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Subscription Title: ${data.title.toString()}",
                      style: TextStyle(
                          fontSize: AddSize.size16,
                          fontWeight: FontWeight.w500),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Subscription Validity: ${data.validity}",
                      style: TextStyle(
                          fontSize: AddSize.size16,
                          fontWeight: FontWeight.w500),),
                  ],
                ),
                SizedBox(
                  height: AddSize.size20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ), backgroundColor: const Color(0xff1b447b),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        package: 'flutter_credit_card',
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if(controller.details.complete == false){
                      showToast("Fill the card details correctly");
                    } else {
                      Stripe.instance.createToken(const CreateTokenParams.card(params: CardTokenParams())).then((value) {
                        log(value.toString());
                        log(value.card.toString());
                        stripePayRepo(
                            subscriptionId: data.id.toString(),
                            stripeToken: value.id.toString(), context: context
                        ).then((value) {
                          if(value.status == true){
                            Get.toNamed(MyRouter.bottomNavbar);

                          }
                          log(jsonEncode(value));
                          showToast(value.message);

                        }

                        );
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
