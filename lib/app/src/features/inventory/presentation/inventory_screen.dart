import 'package:erp_demo/app/src/features/inventory/presentation/transfer_receipt_detail.dart';
import 'package:erp_demo/app/src/features/inventory/provider/inventory_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Utils/app_utils.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an action'),
          content: Text('Please select an option:'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/addInventoryScreen');
              },
              child: Text('Export'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                AppUtils().showSnackbar(context, 'Coming Soon...');
              },
              child: Text('Import'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<InventoryProvider>().getTransferReceipt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showPopup(context);
              },
              child: Text('Transfer'),
            ),
            Expanded(
              child: Consumer<InventoryProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.transferReceipt.length,
                    itemBuilder: (context, index) {
                      final transferReceipt = provider.transferReceipt[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransferReceiptDetail(
                                      transferReceiptId: transferReceipt['ID'],
                                    )),
                          );
                        },
                        child: Container(
                            padding: const EdgeInsets.all(
                              8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'FromLocation: ${transferReceipt['FromLocation']}'),
                                Text(
                                    'ToLocation: ${transferReceipt['ToLocation']}'),
                                Row(
                                  children: [
                                    Text('Status: '),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade300,
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                      ),
                                      child: Text(
                                        '${transferReceipt['Status']}',
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
