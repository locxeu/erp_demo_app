import 'package:erp_demo/app/src/features/purchase_order/provider/purchase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseOrderScreen extends StatefulWidget {
  const PurchaseOrderScreen({super.key});

  @override
  State<PurchaseOrderScreen> createState() => _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PurchaseOrderProvider>(context, listen: false)
        .fetchPurchaseOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addPurchaseOrderScreen');
                  },
                  child: Text('New'),
                ),
                SizedBox(width: 8),
                Text(
                  'Request for Quotation',
                ),
              ],
            ),
            Expanded(
              child: Consumer<PurchaseOrderProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.purchaseOrders.length,
                    itemBuilder: (context, index) {
                      final order = provider.purchaseOrders[index];
                      return Container(
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
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: order['Status'] == 'RFQ'
                                          ? Colors.transparent
                                          : const Color.fromARGB(255, 51, 41, 53),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Text(
                                      order['Status'],
                                      style: TextStyle(
                                        color: order['Status'] == 'RFQ'
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text('Total: ${order['GrandTotal']}')
                            ],
                          ));
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
