import 'package:get/get.dart';

import '../models/model_contracts.dart';
import '../repository/job_module/contracts_repository.dart';

class ContractScreenController extends GetxController {
  Rx<ModelContracts> model = ModelContracts().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() {
    contractsRepo().then((value) {
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
      } else {
        status.value = RxStatus.error();
      }
    });
  }
}
