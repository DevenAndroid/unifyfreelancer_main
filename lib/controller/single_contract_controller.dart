import 'package:get/get.dart';

import '../models/contracts/model_for_timesheet.dart';
import '../models/contracts/model_single_contract.dart';
import '../repository/contracts/single_contract_repository.dart';
import '../repository/contracts/timesheet_data_repository.dart';
import '../utils/api_contant.dart';

class SingleContractController extends GetxController {
  Rx<ModelSingleContract> modelSingleContract = ModelSingleContract().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;
  String? id;
  Rx<ModelTimesheet> modelTimesheet = ModelTimesheet().obs;
  Rx<RxStatus> timesheetStatus = RxStatus.empty().obs;
  RxString startDate = "".obs;
  RxString endDate = "".obs;

  getData() {
    singleContract(id).then((value) {
      modelSingleContract.value = value;
      if (value.status!) {
        status.value = RxStatus.success();
        getTimesheet();
      } else {
        status.value = RxStatus.error();
      }
    });
  }

  getTimesheet() {
    contractTimesheetRepo(
            contract_id: modelSingleContract.value.data!.id.toString(),
            start_date: startDate.value,
            end_date: endDate.value)
        .then((value) {
      print(value);
      modelTimesheet.value = value;
      if (value.status == true) {
        timesheetStatus.value = RxStatus.success();
        print("{timesheetStatus.value}${timesheetStatus.value.isSuccess}");
      } else {
        timesheetStatus.value = RxStatus.error();
      }
    //  showToast(value.message.toString());
    });
  }

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments[0];
    getData();
  }
}
