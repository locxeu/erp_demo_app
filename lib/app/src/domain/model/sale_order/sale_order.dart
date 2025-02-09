class SaleOrder {
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
  final int orderItemId;
  final String sku;
  final int qty;
  final double price;
  final String name;
  final String description;
  final String imageUrl;

  SaleOrder({
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
    required this.orderItemId,
    required this.sku,
    required this.qty,
    required this.price,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory SaleOrder.fromJson(Map<String, dynamic> json) {
    return SaleOrder(
      orderId: json['OrderID'] ?? 0,
      companyId: json['CompanyID'] ?? 0,
      dateIssued: DateTime.parse(json['DateIssued'].toString()),
      deliveryAddress: json['DeliveryAddress'].toString() ?? '',
      shippingMethod: json['ShippingMethod'] ?? '',
      paymentType: json['PaymentType'] ?? '',
      status: json['Status'] ?? '',
      grandTotal: (json['GrandTotal'] ?? 0.0).toDouble(),
      discount: (json['Discount'] ?? 0.0).toDouble(),
      totalTax: (json['TotalTax'] ?? 0.0).toDouble(),
      note: json['Note'].toString() ?? '',
      commission: (json['Commission'] ?? 0.0).toDouble(),
      orderItemId: json['OrderItemID'] ?? 0,
      sku: json['SKU'] ?? '',
      qty: json['Qty'] ?? 0,
      price: (json['Price'] ?? 0.0).toDouble(),
      name: json['Name'] ?? '',
      description: json['Description'].toString() ?? '',
      imageUrl: json['ImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'OrderID': orderId,
      'CompanyID': companyId,
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
      'OrderItemID': orderItemId,
      'SKU': sku,
      'Qty': qty,
      'Price': price,
      'Name': name,
      'Description': description,
      'ImageUrl': imageUrl,
    };
  }
}