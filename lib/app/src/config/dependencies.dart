import 'package:erp/app/src/features/inventory/provider/inventory_provider.dart';
import 'package:erp/app/src/features/purchase_order/provider/purchase_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providersLocal {
  return [
    ChangeNotifierProvider<PurchaseOrderProvider>(
      create: (_) => PurchaseOrderProvider(),
    ),
    ChangeNotifierProvider<InventoryProvider>(
      create: (_) => InventoryProvider(),
    ),
  ];
}