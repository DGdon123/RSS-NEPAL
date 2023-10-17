class CurrenSubscription {
  Data? data;

  CurrenSubscription({this.data});

  CurrenSubscription.fromJson(Map<String, dynamic> json) {
    data = new Data.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? paymentMethod;
  String? subscriptionCharge;
  String? startDate;
  String? nextBillingDate;
  String? endDate;
  String? paymentStatus;
  String? paymentTxnId;
  String? subscriptionStatus;

  Data(
      {this.id,
      this.paymentMethod,
      this.subscriptionCharge,
      this.startDate,
      this.nextBillingDate,
      this.endDate,
      this.paymentStatus,
      this.paymentTxnId,
      this.subscriptionStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['payment_method'];
    subscriptionCharge = json['subscription_charge'];
    startDate = json['start_date'];
    nextBillingDate = json['next_billing_date'];
    endDate = json['end_date'];
    paymentStatus = json['payment_status'];
    paymentTxnId = json['payment_txn_id'];
    subscriptionStatus = json['subscription_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method'] = this.paymentMethod;
    data['subscription_charge'] = this.subscriptionCharge;
    data['start_date'] = this.startDate;
    data['next_billing_date'] = this.nextBillingDate;
    data['end_date'] = this.endDate;
    data['payment_status'] = this.paymentStatus;
    data['payment_txn_id'] = this.paymentTxnId;
    data['subscription_status'] = this.subscriptionStatus;
    return data;
  }
}
