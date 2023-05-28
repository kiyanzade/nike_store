class PaymentRecieptData {
  final bool purchaseSuccess;
  final int payablePrice;
  final String paymentStatus;

  PaymentRecieptData.fromJson(Map<String, dynamic> json)
      : paymentStatus = json["payment_status"],
        payablePrice = json['payable_price'],
        purchaseSuccess = json['purchase_success'];
}
