import 'package:erp_demo/backend/controller/login/product_controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> items = [
    Item(name: 'Sale Order', icon: Icons.shopping_cart, routeName: '/saleOrder'),
    Item(name: 'Purchase Order', icon: Icons.receipt, routeName: '/purchaseOrder'),
    Item(name: 'Inventory', icon: Icons.inventory, routeName: '/inventory'),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: () {
             ProductController().createProduct();
             ProductController().insertProducts();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(items[index].icon),
            title: Text(items[index].name),
            onTap: (){
              Navigator.pushNamed(
                context,
                items[index].routeName
              );
            },
          );
        },
      ),
    );
  }
}

class Item {
  final String name;
  final String routeName;
  final IconData icon;

  Item({required this.name,required this.routeName, required this.icon});
}
