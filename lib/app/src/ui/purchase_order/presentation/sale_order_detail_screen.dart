import 'package:erp_demo/app/src/ui/purchase_order/view_model/purchase_provider.dart';
import 'package:erp_demo/app/src/utils/date_utils.dart';
import 'package:erp_demo/app/src/ui/core/share_widget/product_image.dart';
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
    super.initState();
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
                        'Order ID: ${provider.orderDetails?.orderId}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      Text(
                          'Order Date: ${DateUtil.formatDateString(provider.orderDetails!.dateIssued.toString(), 'dd/MM/yyyy')}'),
                      Text(
                          'Delivery Address: ${provider.orderDetails?.deliveryAddress ?? ''}'),
                      Text(
                          'Shipping Method: ${provider.orderDetails?.shippingMethod}'),
                      Text('Price: ${provider.orderDetails?.grandTotal}'),
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
                                      provider.orderDetails?.imageUrl ?? ''),
                            ),
                            const SizedBox(width: 8),
                            Text(provider.orderDetails?.deliveryAddress ?? ''),
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
