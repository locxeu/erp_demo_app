import 'package:erp_demo/app/src/ui/home/home_screen.dart';
import 'package:erp_demo/app/src/ui/inventory/presentation/add_inventory_screen.dart';
import 'package:erp_demo/app/src/ui/inventory/presentation/inventory_screen.dart';
import 'package:erp_demo/app/src/ui/login/login_screen.dart';
import 'package:erp_demo/app/src/ui/purchase_order/presentation/add_purchase_order.dart';
import 'package:erp_demo/app/src/ui/purchase_order/presentation/purchase_order_screen.dart';
import 'package:erp_demo/app/src/ui/purchase_order/presentation/sale_order_screen.dart';
import 'package:erp_demo/app/src/ui/register/register_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initialRoute = '/login';

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomeScreen(),
    '/purchaseOrder': (context) => const PurchaseOrderScreen(),
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/addPurchaseOrderScreen': (context) => const AddPurchaseOrderScreen(),
    '/saleOrder': (context) => const SaleOrderScreen(),
    '/inventory': (context) => const InventoryScreen(),
    '/addInventoryScreen': (context) => const AddInventoryScreen(),
  };
}