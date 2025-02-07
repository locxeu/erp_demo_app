class PurchaseOrder {
  final int orderId;
  final int companyId;
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
    required this.orderId,
    required this.companyId,
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
    final rawDate = json['DateIssued'];
    DateTime parsedDate;
    if (rawDate is String) {
      parsedDate = DateTime.parse(rawDate);
    } else if (rawDate is DateTime) {
      parsedDate = rawDate;
    } else {
      parsedDate = DateTime.now();
    }
    return PurchaseOrder(
      orderId: json['OrderID'] ?? 0,
      companyId: json['CompanyID'] ?? 0,
      dateIssued: parsedDate,
      deliveryAddress: json['DeliveryAddress'] ?? '',
      shippingMethod: json['ShippingMethod'] ?? '',
      paymentType: json['PaymentType'] ?? '',
      status: json['Status'] ?? '',
      grandTotal: (json['GrandTotal'] ?? 0.0).toDouble(),
      discount: (json['Discount'] ?? 0.0).toDouble(),
      totalTax: (json['TotalTax'] ?? 0.0).toDouble(),
      note: json['Note'] ?? '',
      commission: (json['Commission'] ?? 0.0).toDouble(),
    );
  }
}