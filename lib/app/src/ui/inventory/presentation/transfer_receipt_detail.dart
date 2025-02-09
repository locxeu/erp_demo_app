import 'package:erp_demo/app/src/ui/inventory/view_model/inventory_provider.dart';
import 'package:erp_demo/app/src/utils/date_utils.dart';
import 'package:erp_demo/app/src/ui/core/share_widget/product_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransferReceiptDetail extends StatefulWidget {
  final int transferReceiptId;

  const TransferReceiptDetail({super.key, required this.transferReceiptId});

  @override
  State<TransferReceiptDetail> createState() => _TransferReceiptDetailState();
}

class _TransferReceiptDetailState extends State<TransferReceiptDetail> {
  @override
  void initState() {
    context
        .read<InventoryProvider>()
        .fetchTransferReceiptDetail(widget.transferReceiptId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Receipt Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Consumer<InventoryProvider>(
                builder: (context, provider, child) {
                  if (provider.transferReceiptDetail == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TransferId: ${provider.transferReceiptDetail.first['ID']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'FromLocation: ${provider.transferReceiptDetail.first['FromLocation']}',
                      ),
                      Text(
                          'ToLocation: ${provider.transferReceiptDetail.first['ToLocation']}'),
                      Text(
                        'TransferDate: ${DateUtil.formatDateString(provider.transferReceiptDetail.first['Datetime'].toString(), 'dd/MM/yyyy')}',
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: ProductImage(
                                  imageUrl: provider
                                      .transferReceiptDetail.first['ImageUrl']),
                            ),
                            const SizedBox(width: 8),
                            Text(provider.transferReceiptDetail.first['Name']),
                            const SizedBox(width: 8),
                            Text('Quantity: ${provider.transferReceiptDetail.first['Qty']}'),
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
