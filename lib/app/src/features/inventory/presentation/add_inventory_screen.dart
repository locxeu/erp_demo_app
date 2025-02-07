import 'dart:ffi';

import 'package:erp_demo/app/src/features/inventory/provider/inventory_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart'; // For date formatting

class AddInventoryScreen extends StatefulWidget {
  const AddInventoryScreen({super.key});

  @override
  State<AddInventoryScreen> createState() => _AddInventoryScreenState();
}

class _AddInventoryScreenState extends State<AddInventoryScreen> {
  final TextEditingController _orderNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = 'Address Placeholder';
    context.read<InventoryProvider>().fetchCompanies();
    context.read<InventoryProvider>().fetchInventory();
  }

  void _showInventoryPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<InventoryProvider>(
          builder: (context, provider, child) {
            return AlertDialog(
              title: const Text('Choose Inventory'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.inventory.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        provider.setSelectProduct(provider.inventory[index]);
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(provider.inventory[index]['Name']),
                          Text('Price: ${provider.inventory[index]['Price']}'),
                          Text('Quantity: ${provider.inventory[index]['Qty']}'),
                          Text('Store: ${provider.inventory[index]['Store']}'),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Inventory'),
      ),
      body: SingleChildScrollView(
        // For scrollable content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Consumer<InventoryProvider>(builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle "New" button
                      },
                      child: const Text('New'),
                    ),
                    Row(
                      children: [
                        Text('orderNo'),
                        IconButton(
                          onPressed: () {}, // Handle some action
                          icon: const Icon(Icons.more_vert), // Example icon
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Chip(
                  label: Row(
                    children: [
                      Icon(Icons.delivery_dining),
                      SizedBox(width: 4),
                      Text('Delivery 2'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Action'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        provider.addTransferReceipt(
                          provider.selectedCustomer ?? '',
                          _addressController.text.toString(),
                          TransferStatus.WAITING,
                          provider.selectedInventory!['SKU'],
                          int.parse(_orderNoController.text),
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        provider.addTransferReceipt(
                          provider.selectedCustomer ?? '',
                          _addressController.text.toString(),
                          TransferStatus.DELIVERED,
                          provider.selectedInventory!['SKU'],
                          int.parse(_orderNoController.text),
                        );
                        provider.setSelectProduct(null);
                        provider.setSelectedCustomer(null);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delivery'),
                    ),
                  ],
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Deliver Address'),
                  controller: _addressController,
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Vendor'),
                  value: provider.selectedCustomer,
                  items: provider.companies
                      .map((company) => DropdownMenuItem<String>(
                            value: company['Name'],
                            child: Text(company['Name']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    provider.setSelectedCustomer(value);
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _showInventoryPopUp();
                  },
                  child: const Text('Choose Inventory'),
                ),
                Row(
                  children: [
                    if (provider.selectedInventory != null)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            Text(provider.selectedInventory!['Name']),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: TextFormField(
                                controller: _orderNoController,
                                keyboardType: TextInputType.number,
                              ),
                            )
                          ],
                        ),
                      )
                    else
                      SizedBox(),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
