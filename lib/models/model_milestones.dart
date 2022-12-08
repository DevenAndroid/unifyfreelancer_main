class ModelMilestones {
  String? description;
  String? dueDate;
  String? amount;

  ModelMilestones({this.description, this.dueDate, this.amount});

  ModelMilestones.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    dueDate = json['due_date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['due_date'] = this.dueDate;
    data['amount'] = this.amount;
    return data;
  }
}