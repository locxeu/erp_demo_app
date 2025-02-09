class PurchaseOrder {
  final int orderID;
  final int companyID;
  final DateTime dateIssued;
  final String deliveryAddress;
  final String shippingMethod;
  final String paymentType;
  final String status;
  final double grandTotal;
  final double discount;
  final double totalTax;
  final String note;
  final double commission;

  PurchaseOrder({
    required this.orderID,
    required this.companyID,
    required this.dateIssued,
    required this.deliveryAddress,
    required this.shippingMethod,
    required this.paymentType,
    required this.status,
    required this.grandTotal,
    required this.discount,
    required this.totalTax,
    required this.note,
    required this.commission,
  });

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) {
    return PurchaseOrder(
      orderID: json['OrderID'] ?? 0,
      companyID: json['CompanyID'] ?? 0,
      dateIssued: DateTime.parse(json['DateIssued'].toString()),
      deliveryAddress: json['DeliveryAddress'].toString() ?? '',
      shippingMethod: json['ShippingMethod'] ?? '',
      paymentType: json['PaymentType'] ?? '',
      status: json['Status'] ?? '',
      grandTotal: (json['GrandTotal'] ?? 0.0).toDouble(),
      discount: (json['Discount'] ?? 0.0).toDouble(),
      totalTax: (json['TotalTax'] ?? 0.0).toDouble(),
      note: (json['Note'] ?? '').toString(),
      commission: (json['Commission'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'OrderID': orderID,
      'CompanyID': companyID,
      'DateIssued': dateIssued.toIso8601String(),
      'DeliveryAddress': deliveryAddress,
      'ShippingMethod': shippingMethod,
      'PaymentType': paymentType,
      'Status': status,
      'GrandTotal': grandTotal,
      'Discount': discount,
      'TotalTax': totalTax,
      'Note': note,
      'Commission': commission,
    };
  }
}
