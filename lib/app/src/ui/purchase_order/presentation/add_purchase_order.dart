import 'package:erp_demo/app/src/ui/purchase_order/view_model/purchase_provider.dart';
import 'package:erp_demo/app/src/ui/core/share_widget/product_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPurchaseOrderScreen extends StatefulWidget {
  const AddPurchaseOrderScreen({super.key});

  @override
  State<AddPurchaseOrderScreen> createState() => _AddPurchaseOrderScreenState();
}

class _AddPurchaseOrderScreenState extends State<AddPurchaseOrderScreen> {
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> companies = [];
  String? selectedProduct;

  DateTime? expiryDate;

  // Controllers
  final TextEditingController invoiceAddressController =
      TextEditingController();
  final TextEditingController deliveryAddressController =
      TextEditingController();
  final TextEditingController quotationTemplateController =
      TextEditingController();
  final TextEditingController recurringPlanController = TextEditingController();
  final TextEditingController pricelistController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController productCountController = TextEditingController();

  @override
  @override
  void initState() {
    super.initState();
    // Initialize controllers with default values
    invoiceAddressController.text = 'Invoice Address Placeholder';
    deliveryAddressController.text = 'Delivery Address Placeholder';
    quotationTemplateController.text = 'Quotation Template Placeholder';
    recurringPlanController.text = 'Recurring Plan Placeholder';
    pricelistController.text = 'GrandTotal Placeholder';
    context.read<PurchaseOrderProvider>().fetchProducts();
    context.read<PurchaseOrderProvider>().fetchCompanies();
  }

  @override
  void dispose() {
    // Dispose controllers
    invoiceAddressController.dispose();
    deliveryAddressController.dispose();
    quotationTemplateController.dispose();
    recurringPlanController.dispose();
    pricelistController.dispose();
    super.dispose();
  }

  void _showCreateProductPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<PurchaseOrderProvider>(
          builder: (context, provider, child) {
            return AlertDialog(
              title: const Text('Choose Product'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(provider.products[index]['Name']),
                      leading: ProductImage(
                          imageUrl: provider.products[index]['ImageUrl']),
                      onTap: () {
                        provider.setSelectProduct(provider.products[index]);
                        Navigator.of(context).pop();
                      },
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

  Future<void> _insertPurchaseOrder(String status) async {
    final orderData = {
      'CompanyID': context.read<PurchaseOrderProvider>().selectedCustomer,
      'DateIssued': DateTime.now().toString(),
      'DeliveryAddress': deliveryAddressController.text.toString(),
      'ShippingMethod': 'Shipping Method Placeholder',
      'PaymentType': 'Payment Type Placeholder',
      'Status': status,
      'GrandTotal': pricelistController.text.toString(),
      'Discount': 0.0,
      'TotalTax': 0.0,
      'Note': noteController.text.toString(),
      'Commission': 0.0,
    };
    await context.read<PurchaseOrderProvider>().insertPurchaseOrder(
        SKU:
            context.read<PurchaseOrderProvider>().selectedProduct!['SKU'],
        price: context.read<PurchaseOrderProvider>().selectedProduct!['Price'],
        orderData: orderData);
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New'),
        actions: [
          IconButton(
            onPressed: () {
              // Save action
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // For scrollable content
        padding: const EdgeInsets.all(16.0),
        child: Consumer<PurchaseOrderProvider>(
            builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Action and Quotation Status
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Action button logic
                    },
                    child: const Text('Action'),
                  ),
                  const SizedBox(width: 16),
                  const Chip(label: Text('Quotation')),
                  const SizedBox(width: 8),
                  const Chip(label: Text('Quotation Sent')),
                ],
              ),
              const SizedBox(height: 16),

              // Customer Dropdown
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Vendor'),
                value: provider.selectedCustomer,
                items: provider.companies
                    .map((company) => DropdownMenuItem<int>(
                          value: company['CompanyID'],
                          child: Text(company['Name']),
                        ))
                    .toList(),
                onChanged: (value) {
                  provider.setSelectedCustomer(value);
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: invoiceAddressController,
                decoration: const InputDecoration(labelText: 'Invoice Address'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Delivery Address'),
                controller: deliveryAddressController,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Quotation Template'),
                controller: quotationTemplateController,
              ),
              const SizedBox(height: 16),

              // Expiry Date Picker
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: expiryDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != expiryDate) {
                          setState(() {
                            expiryDate = picked;
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Expiry',
                          hintText: 'Choose Date',
                        ),
                        child: Text(
                          '',
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        expiryDate = null; // Clear the date
                      });
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Recurring Plan'),
                controller: recurringPlanController,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Grand total'),
                controller: pricelistController,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Note'),
                controller: noteController,
              ),

              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    _showCreateProductPopup();
                  },
                  child: Text('Choose Product')),
              const SizedBox(height: 16),
              Row(
                children: [
                  if (provider.selectedProduct != null)
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: ProductImage(
                                imageUrl:
                                    provider.selectedProduct!['ImageUrl']),
                          ),
                          const SizedBox(width: 8),
                          Text(provider.selectedProduct!['Name']),
                          const SizedBox(width: 8),
                        ],
                      ),
                    )
                  else
                    SizedBox(),
                ],
              ),

              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _insertPurchaseOrder('RFQ');
                    },
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _insertPurchaseOrder('Purchase Order');
                    },
                    child: Text('Purchase Order'),
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
