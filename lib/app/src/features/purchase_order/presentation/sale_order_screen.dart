import 'package:erp_demo/app/src/features/purchase_order/presentation/sale_order_detail_screen.dart';
import 'package:erp_demo/app/src/features/purchase_order/provider/purchase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleOrderScreen extends StatefulWidget {
  const SaleOrderScreen({super.key});

  @override
  State<SaleOrderScreen> createState() => _SaleOrderScreenState();
}

class _SaleOrderScreenState extends State<SaleOrderScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PurchaseOrderProvider>(context, listen: false).fetchSaleOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('New'),
                ),
                SizedBox(width: 8),
                Text(
                  'Quotation',
                ),
              ],
            ),
            Expanded(
              child: Consumer<PurchaseOrderProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.saleOrders.length,
                    itemBuilder: (context, index) {
                      final order = provider.saleOrders[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SaleOrderDetailScreen(
                                  orderId: order['OrderID'],
                                )),
                          );
                        },
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order ID: ${order['OrderID']}'),
                                Text('Company ID: ${order['CompanyID']}'),
                                Row(
                                  children: [
                                    Text('Status: '),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text('${order['Status']}'),
                                    )
                                  ],
                                ),
                                Text('Total: ${order['GrandTotal']}')
                              ],
                            )),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
