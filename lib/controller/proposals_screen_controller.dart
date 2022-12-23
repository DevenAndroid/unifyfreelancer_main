import 'package:get/get.dart';

import '../models/proposal_screen_model.dart';
import '../repository/job_module/all_proposals_list_repository.dart';

class ProposalScreenController extends GetxController{

  Rx<RxStatus> status = RxStatus.empty().obs;
  Rx<ModelProposal> model = ModelProposal().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();

  }

  getData(){
    allProposalRepo().then((value) {
      model.value = value;
      if(value.status == true){
        status.value = RxStatus.success();
      }
      else{
        status.value = RxStatus.error();
        if(value.message == "No submit proposals"){
          status.value = RxStatus.success();
          model.value.data = Data(
            activeProposal: [],
            interviewForInvitation: [],
            submittedProposal: []
          );
        }
      }
    });

  }

}