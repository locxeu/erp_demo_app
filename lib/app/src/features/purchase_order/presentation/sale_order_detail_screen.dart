import 'package:erp_demo/app/src/features/purchase_order/provider/purchase_provider.dart';
import 'package:erp_demo/app/src/utils/date_utils.dart';
import 'package:erp_demo/app/src/widget/product_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleOrderDetailScreen extends StatefulWidget {
  final int orderId;

  const SaleOrderDetailScreen({super.key, required this.orderId});

  @override
  State<SaleOrderDetailScreen> createState() => _SaleOrderDetailScreenState();
}

class _SaleOrderDetailScreenState extends State<SaleOrderDetailScreen> {
  @override
  void initState() {
    context.read<PurchaseOrderProvider>().fetchOrderDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sale Order Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Consumer<PurchaseOrderProvider>(
                builder: (context, provider, child) {
                  if (provider.orderDetails == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order ID: ${provider.orderDetails!['productDetail']['OrderID']}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      Text(
                          'Order Date: ${DateUtil.formatDateString(provider.orderDetails!['productDetail']['DateIssued'].toString(), 'dd/MM/yyyy')}'),
                      Text(
                          'Delivery Address: ${provider.orderDetails!['productDetail']['DeliveryAddress']}'),
                      Text(
                          'Shipping Method: ${provider.orderDetails!['productDetail']['ShippingMethod']}'),
                      Text(
                          'Price: ${provider.orderDetails!['productDetail']['Price']}'),
                      SizedBox(height: 24),
                      Text('Product Detail:'),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: ProductImage(
                                  imageUrl:
                                      provider.orderDetails!['productDetail']
                                          ['ImageUrl']),
                            ),
                            const SizedBox(width: 8),
                            Text(provider.orderDetails!['productDetail']
                                ['Name']),
                            const SizedBox(width: 8),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
