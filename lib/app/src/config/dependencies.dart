
import 'package:erp_demo/app/src/ui/inventory/view_model/inventory_provider.dart';
import 'package:erp_demo/app/src/ui/purchase_order/view_model/purchase_provider.dart';
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