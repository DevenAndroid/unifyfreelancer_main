import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/model_subscription.dart';
import '../repository/subscription_repository.dart';
import '../routers/my_router.dart';

class SubscriptionPlanController extends GetxController {
  Rx<ModelSubscriptionPlans> Model = ModelSubscriptionPlans().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;

  RxInt selectedIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() {
    subscriptionPlansRepo().then((value) {
      Model.value = value;
      if (value.status == true) {
        print('RESPONSE OUTPUT::' + status.value.toString());
        status.value = RxStatus.success();
      } else {
        if (value.message.toString() == "Unauthenticated.") {
          logOutUser();
        }
        status.value = RxStatus.error();
      }
    });
  }

  logOutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Get.offAllNamed(MyRouter.loginScreen);
  }
}
