import 'package:get/get.dart';

import '../models/contracts/model_single_contract.dart';
import '../repository/contracts/single_contract_repository.dart';

class SingleContractController extends GetxController{
  Rx<ModelSingleContract> modelSingleContract = ModelSingleContract().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;
  String? id;


  getData(){
    singleContract(id).then((value) {
      modelSingleContract.value = value;
      if(value.status!){
        status.value = RxStatus.success();
      }
      else{
        status.value = RxStatus.error();
      }
    });
  }
@override
  void onInit() {
    super.onInit();
    id = Get.arguments[0];
    getData();
  }
}